setwd("F:/Google Drive/FourthYear/project4980E/scATAC/explorerData")
# load("./GSE149683.Rdata")
memory.limit(size=48000)

# target PMID
target <- "34616060"

library(scATAC.Explorer)
res = queryATAC(pmid=target, metadata_only = FALSE)
scData <- res

library(Signac)
library(Seurat)
library(GenomeInfoDb)
library(EnsDb.Hsapiens.v75)
library(ggplot2)
library(patchwork)
set.seed(1234)

# take data from only metdata
scDataNew = scData[[1]]

# create seurat objects
GSE149683_assay <- CreateChromatinAssay(counts = counts(scDataNew), sep = c("-", "-"))
GSE149683_obj <- CreateSeuratObject(counts = GSE149683_assay , assay = "peaks")
GSE149683_obj[['peaks']]

granges(GSE149683_obj)

# extract gene annotations from EnsDb
annotations <- GetGRangesFromEnsDb(ensdb = EnsDb.Hsapiens.v75)

# change to UCSC style since the data was mapped to hg19
seqlevelsStyle(annotations) <- 'UCSC'

# add the gene information to the object
Annotation(GSE149683_obj) <- annotations

# CONTINUE HERE - Normalization and linear dimensional reduction
GSE149683_obj <- RunTFIDF(GSE149683_obj)
GSE149683_obj <- FindTopFeatures(GSE149683_obj, min.cutoff = 'q0')
GSE149683_obj <- RunSVD(GSE149683_obj)

DepthCor(GSE149683_obj)

# Non-linear dimension reduction and clustering
GSE149683_obj <- RunUMAP(object = GSE149683_obj, reduction = 'lsi', dims = 2:30)
GSE149683_obj <- FindNeighbors(object = GSE149683_obj, reduction = 'lsi', dims = 2:30)
GSE149683_obj <- FindClusters(object = GSE149683_obj, verbose = FALSE, algorithm = 3)
DimPlot(object = GSE149683_obj, label = TRUE) + NoLegend()

### Manual IDENTS, add labels onto clustered
Idents(object = GSE149683_obj)
Idents(GSE149683_obj) <- scDataNew$label.cell_label

clusterList <- unique(Idents(GSE149683_obj))
clusterList

# Find differentially accessible peaks between clusters

# change back to working with peaks instead of gene activities
DefaultAssay(GSE149683_obj) <- 'peaks'

# cellList <- c('pro-B',"pDC","DC","CD14 Mono",'CD16 Mono')

library(data.table)
library(stringr)

cellList <- unique(Idents(GSE149683_obj))
# cellList <- cellList[-(1:6)]

dir.create(target)
rm(GSE149683_assay)
rm(res)

### begin extraction of BED files
for (cell in cellList){
  
  print(c("Running FindMarkers for", cell))
  
  da_peaks <- FindMarkers(
    object = GSE149683_obj,
    ident.1 = cell,
    # ident.2 = "CD14 Mono",
    min.pct = 0.01,
    test.use = 'LR',
    only.pos = TRUE,
    #latent.vars = 'peak_region_fragments'
  )
  # filter non-significant values
  print(c("Filtering for ", cell))
  tryCatch({
    da_peaks <- subset(da_peaks, p_val_adj<0.05)
    setDT(da_peaks, keep.rownames = TRUE)[]
    output <- str_split_fixed(da_peaks$rn, "-", 3)
    output <- data.frame(output)
    # expand peaks 
    # typeof(output[,"Start"])
    colnames(output) <- c("ChrNum", "Start", "End")
    print(c("Expanding peaks of ", cell))
    output[,"Start"] <- as.numeric(output[,"Start"]) - 100
    print("Expanding start by 100")
    output[,"End"] <- as.numeric(output[,"End"]) + 100
    print("Expanding end by 100")
    print("Looking for spaces")
    modCell <- str_replace_all(cell, "\\s", ".")
    print("looking for /")
    modCell <- str_replace_all(modCell, "\\/", "_S_")
    print("Looking for ?")
    modCell <- str_replace_all(modCell, "\\?", "_Q_")
    print(c("Writing to ", paste("F:/Google Drive/FourthYear/project4980E/scATAC/explorerData/", target, "/", modCell, ".bed", sep = "", collapse = NULL)))
    write.table(output,paste("F:/Google Drive/FourthYear/project4980E/scATAC/explorerData/", target, "/", modCell, ".bed", sep = "", collapse = NULL), sep = "\t",row.names = FALSE, col.names = FALSE, quote = FALSE)
  }, error=function(e){cat("ERROR : Probably no features of p value less than 0.05", "\n")})
}
