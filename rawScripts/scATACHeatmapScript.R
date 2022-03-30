# # do another heat map without correction, nominally significant significant, less than 0.1. There.... all pvalues fall below threshhold, set to 0. 

library(reshape2)
library(forcats)
library(tidyverse)

setwd("F:/Google Drive/FourthYear/project4980E/scATAC/outputs/pbmc")

fileNames <- list.files(pattern=".txt")
fileNames

# raw p values
RA <- read.table("gwasOutputRAbaselessCorrect.cell_type_results.txt", header=TRUE, sep="\t", quote="")
MS <- read.table("gwasOutputMSbaselessCorrect.cell_type_results.txt", header=TRUE, sep="\t", quote="")
schizo <- read.table("gwasOutputSCHIZObaselessCorrect.cell_type_results.txt", header=TRUE, sep="\t", quote="")
CAD <- read.table("gwasOutputCADbaselessCorrect.cell_type_results.txt", header=TRUE, sep="\t", quote="")
lupus <- read.table("gwasOutputLUPUSbaselessCorrect.cell_type_results.txt", header=TRUE, sep="\t", quote="")
IBD <- read.table("gwasOutputIBDbaselessCorrect.cell_type_results.txt", header=TRUE, sep="\t", quote="")
CELI <- read.table("gwasOutputCELIACbaselessCorrect.cell_type_results.txt", header=TRUE, sep="\t", quote="")
UC <- read.table("gwasOutputULCbaselessCorrect.cell_type_results.txt", header=TRUE, sep="\t", quote="")
CROHNS <- read.table("gwasOutputCROHNbaselessCorrect.cell_type_results.txt", header=TRUE, sep="\t", quote="")
PBC <- read.table("gwasOutputPBCbaselessCorrect.cell_type_results.txt", header=TRUE, sep="\t", quote="")
T1D <- read.table("gwasOutputT1DbaselessCorrect.cell_type_results.txt", header=TRUE, sep="\t", quote="")

# sorted types
sortedRA <- RA[order(RA$Name),]
sortedMS <- MS[order(MS$Name),]
sortedSchizo <- schizo[order(schizo$Name),]
sortedCAD <- CAD[order(CAD$Name),]
sortedLupus <- lupus[order(lupus$Name),]
sortedIBD <- IBD[order(IBD$Name),]
sortedCELI <- CELI[order(CELI$Name),]
sortedUC <- UC[order(UC$Name),]
sortedCROHNS <- CROHNS[order(CROHNS$Name),]
sortedT1D <- T1D[order(T1D$Name),]
sortedPBC <- PBC[order(PBC$Name),]
sortedNames <- data.frame(sortedRA[,c("Name"), drop=FALSE])

# FDR p values log10
pValRA <- data.frame(log10(p.adjust(sortedRA$Coefficient_P_value, method="BH", n=13)) * (-1))
pValMS <- data.frame(log10(p.adjust(sortedMS$Coefficient_P_value, method="BH", n=13)) * (-1))
pValSchizo <- data.frame(log10(p.adjust(sortedSchizo$Coefficient_P_value, method="BH", n=13)) * (-1))
pValCAD <- data.frame(log10(p.adjust(sortedCAD$Coefficient_P_value, method="BH", n=13)) * (-1))
pValLupus <- data.frame(log10(p.adjust(sortedLupus$Coefficient_P_value, method="BH", n=13)) * (-1))
pValIBD <- data.frame(log10(p.adjust(sortedIBD$Coefficient_P_value, method="BH", n=13)) * (-1))
pValCELI <- data.frame(log10(p.adjust(sortedCELI$Coefficient_P_value, method="BH", n=13)) * (-1))
pValUC <- data.frame(log10(p.adjust(sortedUC$Coefficient_P_value, method="BH", n=13)) * (-1))
pValCROHNS <- data.frame(log10(p.adjust(sortedCROHNS$Coefficient_P_value, method="BH", n=13)) * (-1))
pValT1D <- data.frame(log10(p.adjust(sortedT1D$Coefficient_P_value, method="BH", n=13)) * (-1))
pValPBC <- data.frame(log10(p.adjust(sortedPBC$Coefficient_P_value, method="BH", n=13)) * (-1))

### manage names of cell types

# immuneCellTypes <- data.frame(cellTypes=c("peripheral.blood.mononuclear.cell...AML","natural.killer.cell","alternatively.activated.macrophage","regulatory.T.cell","macrophage...T.6days.untreated","monocyte...T.0days","thymus","T.cell","mononuclear.cell.of.bone.marrow...AML","lymphocyte.of.B.lineage...CTR...ALL","macrophage...T.6days.B.glucan","common.myeloid.progenitor..CD34.positive","CD14.positive..CD16.negative.classical.monocyte","erythroblast","CD4.positive.helper.T.cell","macrophage","CD34.negative..CD41.positive..CD42.positive.megakaryocyte.cell","T.helper.2.cell","CD14.positive.monocyte","T.helper.1.cell","inflammatory.macrophage","CD8.positive..alpha.beta.T.cell","CD4.positive..alpha.beta.T.cell","CD1c.positive.myeloid.dendritic.cell","myeloid.cell...AML","macrophage...T.6days.LPS","B.cell"))

# allCellTypes <-rbind(immuneCellTypes,neuralCellTypes,endothelialCellTypes,extraEmbryoCellTypes,epithelialCellTypes,fibroblastCellTypes,reproductiveCellTypes,stemCellTypes,muscleCellTypes,skinCellTypes,pancreasCellTypes,cardiovascularCellTypes,kidneyCellTypes,digestiveCellTypes,lungCellTypes,endocrineCellTypes,eyeCellTypes,cellLinesCellTypes,otherCellTypes)


manualCellTypes <- allCellTypes$cellTypes

### create matrix for graph

finalAllOrdered <- cbind(sortedNames,pValRA,pValMS,pValSchizo,pValCAD,pValLupus,pValIBD,pValCELI,pValUC,pValCROHNS,pValT1D,pValPBC)

colnames(finalAllOrdered) <-c("Name","Rheumatoid Arthritis","Multiple Sclerosis","Schizophrenia","Coronary Artery Disease","Lupus","Inflammatory Bowel Disease","Celiac Disease","Ulcerative Colitis","Crohn's Disease","Type 1 Diabetes", "Primary Biliary Cirrhosis")


library(RColorBrewer)
library(dbplyr)

# clustered <- c(rep("Immune",dplyr::count(immuneCellTypes)),rep("CNS",dplyr::count(neuralCellTypes)),rep("Endothelial",dplyr::count(endothelialCellTypes)),rep("Extra\nEmbryo",dplyr::count(extraEmbryoCellTypes)),rep("Epithelial",dplyr::count(epithelialCellTypes)),rep("Fibroblast",dplyr::count(fibroblastCellTypes)),rep("Reprod.",dplyr::count(reproductiveCellTypes)),rep("Stem\nCell",dplyr::count(stemCellTypes)),rep("Muscle",dplyr::count(muscleCellTypes)),rep("Skin",dplyr::count(skinCellTypes)),rep("Pancreas",dplyr::count(pancreasCellTypes)),rep("CV",dplyr::count(cardiovascularCellTypes)),rep("Kidney",dplyr::count(kidneyCellTypes)),rep("Digestive",dplyr::count(digestiveCellTypes)),rep("Lung",dplyr::count(lungCellTypes)),rep("Endocrine",dplyr::count(endocrineCellTypes)),rep("Eye",dplyr::count(eyeCellTypes)),rep("Other",dplyr::count(otherCellTypes)))

finalAllOrdered2 <- finalAllOrdered[,-1]
rownames(finalAllOrdered2) <- finalAllOrdered[,1]

matrixData <- as.matrix(finalAllOrdered2)

matrixData2 <- t(matrixData)



# other Complex Heatmap

par(bg = "white")

library(ComplexHeatmap)
library(grid)
ht_opt
ht_opt(RESET = TRUE)
heatmap(matrixData2, Colv=NA, Rowv=NA, scale='column')

ht_opt$TITLE_PADDING = unit(c(24, 36), "points")
ht_opt$ROW_ANNO_PADDING = unit(c(8,8), "points")

# disaese y-axis
colours <- colorRampPalette(c("white", "red"))

allHeatMap2 <- Heatmap(matrixData2, name="Cell Types Sig.", border = TRUE, border_gp = gpar(col = "gray"), row_gap = unit(0, "mm"), column_gap = unit(0, "mm"), height = unit(20, "cm"),
                       # row_title = "Disease associations with peripheral blood mononuclear cells",
                       row_title_gp = gpar(fontsize = 20),
                       # column_split = data.frame(clustered),
                       col=colours(20),
                       column_title = "Disease associations with peripheral blood mononuclear cells (FDR 0.05)",
                       column_title_rot = 0,
                       column_title_gp = gpar(fontsize = 20, fill = "white", col = "black", border = "white"),
                       # column_order = manualCellTypes,
                       column_names_gp = grid::gpar(fontsize = 15),
                       #rect_gp = gpar(col = "gray", lwd = 1),
                       cluster_rows = TRUE,
                       row_names_gp = grid::gpar(fontsize = 13),
                       #row_names_rot = 45,
                       heatmap_legend_param = list(title = "Cell Type Significance", title_position = "leftcenter-rot", labels_rot = 45,
                                                   legend_height = unit(4, "cm")),
                       cell_fun = function(j, i, x, y, width, height, fill) {
                         if(matrixData2[i, j] > 1.3)
                           grid.text(sprintf("%.1f", matrixData2[i, j]), x, y, gp = gpar(fontsize = 20))
                       }
)
print(allHeatMap2)
draw(allHeatMap2, column_title = "Cell subtypes")
