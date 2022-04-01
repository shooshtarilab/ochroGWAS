# # do another heat map without correction, nominally significant significant, less than 0.1. There.... all pvalues fall below threshhold, set to 0. 

library(reshape2)
library(forcats)
library(tidyverse)
library(ComplexHeatmap)
library(stringr)
library(RColorBrewer)
library(dbplyr)

setwd("F:/Google Drive/FourthYear/project4980E/data/sumStats/atlas")

fileNames <- list.files(pattern=".txt")
fileNames

finalAll <- "cbind(sortedNames"

colVector <- c("Name")

for (file in fileNames) {
  
  diseaseName <- sub("_[^_]+$", "", str_extract(file, "([A-Z])\\w+"))
  
  # read table
  assign(diseaseName, read.table(file, header=TRUE, sep="\t", quote=""))
  
  # create sorted table of FDR p values
  assign(paste("FDR", diseaseName, sep=""), data.frame(log10(p.adjust(eval(as.name(diseaseName))[order(eval(as.name(diseaseName))$Name),]$Coefficient_P_value, method="BH", n=137)) * (-1)))
  
  # build heatmap matrix string
  finalAll <- paste(finalAll, ", FDR", diseaseName, sep="")
  
  # build colnames of final matrix
  colVector <- append(colVector, diseaseName)
  
}

sortedNames <- data.frame(eval(as.name(diseaseName))[order(eval(as.name(diseaseName))$Name),][,c("Name"), drop=FALSE])
finalAll <- paste(finalAll, ")", sep="")

### manage names of cell types

immuneCellTypes <- data.frame(cellTypes=c("peripheral.blood.mononuclear.cell...AML","natural.killer.cell","alternatively.activated.macrophage","regulatory.T.cell","macrophage...T.6days.untreated","monocyte...T.0days","thymus","T.cell","mononuclear.cell.of.bone.marrow...AML","lymphocyte.of.B.lineage...CTR...ALL","macrophage...T.6days.B.glucan","common.myeloid.progenitor..CD34.positive","CD14.positive..CD16.negative.classical.monocyte","erythroblast","CD4.positive.helper.T.cell","macrophage","CD34.negative..CD41.positive..CD42.positive.megakaryocyte.cell","T.helper.2.cell","CD14.positive.monocyte","T.helper.1.cell","inflammatory.macrophage","CD8.positive..alpha.beta.T.cell","CD4.positive..alpha.beta.T.cell","CD1c.positive.myeloid.dendritic.cell","myeloid.cell...AML","macrophage...T.6days.LPS","B.cell"))

neuralCellTypes <- data.frame(cellTypes=c("brain","putamen","neural.stem.progenitor.cell","globus.pallidus","astrocyte.of.the.cerebellum","inferior.parietal.cortex","middle.frontal.gyrus","brain.pericyte","Ammon.s.horn","caudate.nucleus","astrocyte","bipolar.neuron","spinal.cord","superior.temporal.gyrus","pons","medulla.oblongata","occipital.lobe","midbrain"))

endothelialCellTypes <- data.frame(cellTypes=c("dermis.microvascular.lymphatic.vessel.endothelial.cell","brain.microvascular.endothelial.cell","dermis.blood.vessel.endothelial.cell","pulmonary.artery.endothelial.cell","glomerular.endothelial.cell"))

extraEmbryoCellTypes <- data.frame(cellTypes=c("amniotic.stem.cell","placenta","dedifferentiated.amniotic.fluid.mesenchymal.stem.cell","trophoblast.cell","umbilical.cord"))

epithelialCellTypes <- data.frame(cellTypes=c("glomerular.visceral.epithelial.cell","retinal.pigment.epithelial.cell","mammary.epithelial.cell","amniotic.epithelial.cell","epithelial.cell.of.prostate","non.pigmented.ciliary.epithelial.cell","choroid.plexus.epithelial.cell","renal.cortical.epithelial.cell","bronchial.epithelial.cell","kidney.epithelial.cell","epithelial.cell.of.proximal.tubule"))

fibroblastCellTypes <- data.frame(cellTypes=c("fibroblast.of.pedal.digit.skin","fibroblast.of.peridontal.ligament","skin.fibroblast","fibroblast.of.dermis","foreskin.fibroblast","fibroblast.of.the.aortic.adventitia","fibroblast.of.skin.of.abdomen","fibroblast.of.the.conjunctiva","fibroblast.of.gingiva","fibroblast.of.upper.leg.skin","fibroblast.of.mammary.gland","fibroblast.of.lung","fibroblast.of.pulmonary.artery","fibroblast.of.arm"))

reproductiveCellTypes <- data.frame(cellTypes=c("testis","prostate.gland","ovary"))

stemCellTypes <- data.frame(cellTypes=c("iPS.DF.19.11","induced.pluripotent.stem.cell","hematopoietic.multipotent.progenitor.cell","stromal.cell.of.bone.marrow","H9","iPS.DF.4.7","H1.hESC","iPS.DF.6.9","iPS.DF.19.7","H7.hESC"))

muscleCellTypes <- data.frame(cellTypes=c("thoracic.segment.muscle","muscle.of.trunk","muscle.of.back","muscle.of.arm","myotube","smooth.muscle.cell.of.the.brain.vasculature","hindlimb.muscle","muscle.of.leg","forelimb.muscle"))

skinCellTypes <- data.frame(cellTypes=c("foreskin.melanocyte","foreskin.keratinocyte","keratinocyte","skin.of.body"))

pancreasCellTypes <- data.frame(cellTypes=c("body.of.pancreas","pancreas"))

cardiovascularCellTypes <- data.frame(cellTypes=c("cardiac.mesoderm","heart","heart.left.ventricle"))

kidneyCellTypes <- data.frame(cellTypes=c("renal.pelvis","left.kidney","left.renal.cortex.interstitium","right.kidney","renal.cortex.interstitium","left.renal.pelvis","right.renal.pelvis","right.renal.cortex.interstitium","kidney"))

digestiveCellTypes <- data.frame(cellTypes=c("large.intestine","small.intestine","tongue","hepatocyte","stomach","spleen"))

lungCellTypes <- data.frame(cellTypes=c("right.lung","lung","left.lung"))

endocrineCellTypes <- data.frame(cellTypes=c("thyroid.gland","adrenal.gland"))

eyeCellTypes <- data.frame(cellTypes=c("eye","retina"))

otherCellTypes <- data.frame(cellTypes=c("embryonic.facial.prominence","limb","adipocyte","urinary.bladder"))

allCellTypes <-rbind(immuneCellTypes,neuralCellTypes,endothelialCellTypes,extraEmbryoCellTypes,epithelialCellTypes,fibroblastCellTypes,reproductiveCellTypes,stemCellTypes,muscleCellTypes,skinCellTypes,pancreasCellTypes,cardiovascularCellTypes,kidneyCellTypes,digestiveCellTypes,lungCellTypes,endocrineCellTypes,eyeCellTypes,otherCellTypes)

manualCellTypes <- allCellTypes$cellTypes

### create matrix for graph

finalAll <- eval(parse(text=finalAll))

# finalAll <- cbind(sortedNames,pValRA,pValMS,pValSchizo,pValAlz,pValFG,pValCAD,pValDT2,pValLupus,pValIBD,pValANOR,pValAUTI,pValCELI,pValDS,pValHDL,pValLDL,pValUC,pValBMI,pValCROHNS,pValEDU1,pValEDU2,pValNEUROTICISM,pValSMOKED,pValSWB,pValT1D,pValTRIG,pValPBC,pValBIP)

colnames(finalAll) <- colVector

# finalAll, match order of clustered cell types
finalAllOrdered <- finalAll %>%
  slice(match(manualCellTypes, Name))

finalAllOrdered$Name <- factor(finalAllOrdered$Name, levels=manualCellTypes)

meltedData <- melt(finalAllOrdered)
colnames(meltedData) <- c("Cell_Type", "Disease", "-log10(pVal)")

clustered <- c(rep("Immune",dplyr::count(immuneCellTypes)),rep("CNS",dplyr::count(neuralCellTypes)),rep("Endothelial",dplyr::count(endothelialCellTypes)),rep("Extra\nEmbryo",dplyr::count(extraEmbryoCellTypes)),rep("Epithelial",dplyr::count(epithelialCellTypes)),rep("Fibroblast",dplyr::count(fibroblastCellTypes)),rep("Reprod.",dplyr::count(reproductiveCellTypes)),rep("Stem\nCell",dplyr::count(stemCellTypes)),rep("Muscle",dplyr::count(muscleCellTypes)),rep("Skin",dplyr::count(skinCellTypes)),rep("Pancreas",dplyr::count(pancreasCellTypes)),rep("CV",dplyr::count(cardiovascularCellTypes)),rep("Kidney",dplyr::count(kidneyCellTypes)),rep("Digestive",dplyr::count(digestiveCellTypes)),rep("Lung",dplyr::count(lungCellTypes)),rep("Endocrine",dplyr::count(endocrineCellTypes)),rep("Eye",dplyr::count(eyeCellTypes)),rep("Other",dplyr::count(otherCellTypes)))

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


ht_opt$TITLE_PADDING = unit(c(24, 36), "points")
ht_opt$ROW_ANNO_PADDING = unit(c(-8,-8), "points")

# disaese y-axis

colours <- colorRampPalette(c("white", "red"))

allHeatMap <- Heatmap(matrixData2, name="Cell Types Sig.", border = TRUE, border_gp = gpar(col = "gray"), row_gap = unit(0, "mm"), column_gap = unit(0, "mm"),
                       # row_title = "Cell type significance across complex diseases (FDR 0.05)",
                       column_split = data.frame(clustered),
                       col=colours(20),
                       column_title_rot = 0,
                       column_title_gp = gpar(fontsize = 15, fill = "white", col = "black", border = "white"),
                       column_order = manualCellTypes,
                       column_names_gp = grid::gpar(fontsize = 11),
                       #rect_gp = gpar(col = "gray", lwd = 1),
                       cluster_rows = TRUE,
                       row_names_gp = grid::gpar(fontsize = 10),
                       #row_names_rot = 45,
                       heatmap_legend_param = list(title = "Cell Type Significance", title_position = "leftcenter-rot", labels_rot = 45,
                                                   legend_height = unit(5, "cm")),
                       cell_fun = function(j, i, x, y, width, height, fill) {
                         if(matrixData2[i, j] > 1.3)
                           grid.text(sprintf("%.1f", matrixData2[i, j]), x, y, gp = gpar(fontsize = 10, col = "black"))
                       }
)
print(allHeatMap)
draw(allHeatMap, column_title = "Disease associations with OCR across different cell types (FDR 0.05)", column_title_gp = gpar(fontsize = 15), padding = unit(c(0, 10, -40, 10), "mm"))
