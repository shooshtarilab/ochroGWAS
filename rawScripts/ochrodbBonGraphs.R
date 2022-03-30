library(tidyverse)

setwd("F:/Google Drive/FourthYear/project4980E/outputs")

allFiles <- list.files(path="F:/Google Drive/FourthYear/project4980E/outputs/NCLstep3", pattern=".txt", full.names = TRUE, recursive = FALSE)
allFiles

toRead <- 
  "F:/Google Drive/FourthYear/project4980E/outputs/NCLstep3/gwasOutputPASS_Rheumatoid_Arthritis.cell_type_results.txt"  
rawOutput <- read.table(toRead, header=TRUE, sep="\t", quote="")

newFiles <- list.files(path="F:/Google Drive/FourthYear/project4980E/outputs/NCLstep3noref", pattern=".txt", full.names = TRUE, recursive = FALSE)
newFiles

rawOutput <- read.table("F:/Google Drive/FourthYear/project4980E/outputs/gwasOutputAlzbaseless.cell_type_results.txt", header=TRUE, sep="\t", quote="")
rawOutput <- read.table("F:/Google Drive/FourthYear/project4980E/outputs/gwasOutputFGbaseless.cell_type_results.txt", header=TRUE, sep="\t", quote="")
rawOutput <- read.table("F:/Google Drive/FourthYear/project4980E/outputs/gwasOutputCADbaseless.cell_type_results.txt", header=TRUE, sep="\t", quote="")
rawOutput <- read.table("F:/Google Drive/FourthYear/project4980E/outputs/gwasOutputDT2baseless.cell_type_results.txt", header=TRUE, sep="\t", quote="")
rawOutput <- read.table("F:/Google Drive/FourthYear/project4980E/outputs/gwasOutputLupusbaseless.cell_type_results.txt", header=TRUE, sep="\t", quote="")
rawOutput <- read.table("F:/Google Drive/FourthYear/project4980E/outputs/gwasOutputIBDbaseless.cell_type_results.txt", header=TRUE, sep="\t", quote="")
rawOutput <- read.table("F:/Google Drive/FourthYear/project4980E/outputs/gwasOutputAnorexbaseless.cell_type_results.txt", header=TRUE, sep="\t", quote="")
rawOutput <- read.table("F:/Google Drive/FourthYear/project4980E/outputs/gwasOutputAutismbaseless.cell_type_results.txt", header=TRUE, sep="\t", quote="")
rawOutput <- read.table("F:/Google Drive/FourthYear/project4980E/outputs/gwasOutputCeliacbaseless.cell_type_results.txt", header=TRUE, sep="\t", quote="")
rawOutput <- read.table("F:/Google Drive/FourthYear/project4980E/outputs/gwasOutputDSbaseless.cell_type_results.txt", header=TRUE, sep="\t", quote="")
rawOutput <- read.table("F:/Google Drive/FourthYear/project4980E/outputs/gwasOutputHDLbaseless.cell_type_results.txt", header=TRUE, sep="\t", quote="")
rawOutput <- read.table("F:/Google Drive/FourthYear/project4980E/outputs/gwasOutputLDLbaseless.cell_type_results.txt", header=TRUE, sep="\t", quote="")
rawOutput <- read.table("F:/Google Drive/FourthYear/project4980E/outputs/gwasOutputUCbaseless.cell_type_results.txt", header=TRUE, sep="\t", quote="")
rawOutput <- read.table("F:/Google Drive/FourthYear/project4980E/outputs/gwasOutputBMIbaseless.cell_type_results.txt", header=TRUE, sep="\t", quote="")
rawOutput <- read.table("F:/Google Drive/FourthYear/project4980E/outputs/gwasOutputCROHNSbaseless.cell_type_results.txt", header=TRUE, sep="\t", quote="")
rawOutput <- read.table("F:/Google Drive/FourthYear/project4980E/outputs/gwasOutputEDU1baseless.cell_type_results.txt", header=TRUE, sep="\t", quote="")
rawOutput <- read.table("F:/Google Drive/FourthYear/project4980E/outputs/gwasOutputEDU2baseless.cell_type_results.txt", header=TRUE, sep="\t", quote="")
rawOutput <- read.table("F:/Google Drive/FourthYear/project4980E/outputs/gwasOutputNeuroticismbaseless.cell_type_results.txt", header=TRUE, sep="\t", quote="")
rawOutput <- read.table("F:/Google Drive/FourthYear/project4980E/outputs/gwasOutputPBCbaseless.cell_type_results.txt", header=TRUE, sep="\t", quote="")
rawOutput <- read.table("F:/Google Drive/FourthYear/project4980E/outputs/gwasOutputSmokedbaseless.cell_type_results.txt", header=TRUE, sep="\t", quote="")
rawOutput <- read.table("F:/Google Drive/FourthYear/project4980E/outputs/gwasOutputSWBbaseless.cell_type_results.txt", header=TRUE, sep="\t", quote="")
rawOutput <- read.table("F:/Google Drive/FourthYear/project4980E/outputs/gwasOutputT1Dbaseless.cell_type_results.txt", header=TRUE, sep="\t", quote="")
rawOutput <- read.table("F:/Google Drive/FourthYear/project4980E/outputs/gwasOutputTRIGbaseless.cell_type_results.txt", header=TRUE, sep="\t", quote="")
rawOutput <- read.table("F:/Google Drive/FourthYear/project4980E/outputs/NCLstep3noref/gwasOutputPASS_Multiple_sclerosis.cell_type_results.txt", header=TRUE, sep="\t", quote="")

# GOOD
# MS, RA (Bad BON), SCHIZO, Crohn's (Bad BON), EDU2, Bipolar (Almost good BON), Celiac, Triglycerides, 

# Not sign but ok
# ALZ, EDU1, Anorexia, Autism, IBD,

# Very little sign
# BMI, CAD, Ever smoked, FG, HDL, LDL, Lupus, Neuro, SWB, T1D, T2D, ULC, PBC, FG


# Sort the p-values by name
sortedTable <- rawOutput[order(rawOutput$Name),]

sortedCellTypes <- data.frame(sortedTable[,c("Name"), drop=FALSE])

# convert into log10 pvalue 
logPVal <- data.frame(log10(sortedTable[,c("Coefficient_P_value"), drop=FALSE]) * (-1))

# Bonferonni values

bonFinal <- cbind(sortedCellTypes,logPVal)

# graphs with Bonferonni Correction / red represents related cell types

bonPlot <- ggplot(bonFinal, aes(x=reorder(Name, -Coefficient_P_value), y=Coefficient_P_value, fill=Name)) + 
  geom_bar(stat="identity", width=0.8) +
  scale_fill_manual(values = c("brain" = "deeppink",
                               "putamen" = "deeppink",
                               "neural.stem.progenitor.cell" = "deeppink",
                               "globus.pallidus" = "deeppink",
                               "astrocyte.of.the.cerebellum" = "deeppink",
                               "astrocyte" = "deeppink",
                               "inferior.parietal.cortex" = "deeppink",
                               "middle.frontal.gyrus" = "deeppink",
                               "brain.pericyte" = "deeppink",
                               "Ammon.s.horn" = "deeppink",
                               "caudate.nucleus" = "deeppink",
                               "bipolar.neuron" = "deeppink",
                               "spinal.cord" = "deeppink",
                               "superior.temporal.gyrus" = "deeppink",
                               "pons" = "deeppink",
                               "medulla.oblongata" = "deeppink",
                               "occipital.lobe" = "deeppink",
                               "midbrain" = "deeppink",
                               "T.helper.1.cell" = "darkturquoise",
                               "regulatory.T.cell" = "darkturquoise",
                               "CD4.positive..alpha.beta.T.cell" = "darkturquoise",
                               "T.cell" = "darkturquoise",
                               "natural.killer.cell" = "darkturquoise",
                               "thymus" = "darkturquoise",
                               "T.helper.2.cell" = "darkturquoise",
                               "CD4.positive.helper.T.cell" = "darkturquoise",
                               "lymphocyte.of.B.lineage...CTR...ALL" = "darkturquoise",
                               "alternatively.activated.macrophage" = "darkturquoise",
                               "monocyte...T.0days" = "darkturquoise",
                               "peripheral.blood.mononuclear.cell...AML" = "darkturquoise",
                               "macrophage...T.6days.untreated" = "darkturquoise",
                               "monocyte...T.0days" = "darkturquoise",
                               "mononuclear.cell.of.bone.marrow...AML" = "darkturquoise",
                               "macrophage...T.6days.B.glucan" = "darkturquoise",
                               "common.myeloid.progenitor..CD34.positive" = "darkturquoise",
                               "CD14.positive..CD16.negative.classical.monocyte" = "darkturquoise",
                               "erythroblast" = "darkturquoise",
                               "macrophage" = "darkturquoise",
                               "CD34.negative..CD41.positive..CD42.positive.megakaryocyte.cell" = "darkturquoise",
                               "CD14.positive.monocyte" = "darkturquoise",
                               "inflammatory.macrophage" = "darkturquoise",
                               "CD8.positive..alpha.beta.T.cell" = "darkturquoise",
                               "CD1c.positive.myeloid.dendritic.cell" = "darkturquoise",
                               "myeloid.cell...AML" = "darkturquoise",
                               "macrophage...T.6days.LPS" = "darkturquoise",
                               "B.cell" = "darkturquoise"
  ), guide="none") +
  scale_colour_manual(name='Immune Cell Types', values='red') +
  geom_hline(yintercept=-log10(0.05/nrow(sortedTable))) + 
  labs(title="Cell Type Significance with Bonferonni Correction", x="Cell Type", y="-log10(p)") + 
  theme(axis.text.x=element_text(size=7, angle=90, hjust=1)) +
  scale_x_discrete()
print(bonPlot)

# adjusted p values for BH (FDR)

pValBH <- p.adjust(sortedTable$Coefficient_P_value, method="BH", n=length(sortedTable$Coefficient_P_value))

pValLogBH <- data.frame(log10(pValBH) * (-1)) # adds log10 to p vals, return logged p vals

colnames(pValLogBH) <- c("log10p")

BHfinal <- cbind(sortedCellTypes,pValLogBH) # stitch together names and p vals

BHplot <- ggplot(BHfinal, aes(x=reorder(Name, -log10p), y=log10p, fill=Name)) + 
  geom_bar(stat="identity", width=0.9, position=position_dodge2(0.5)) +
  scale_fill_manual(values = c("brain" = "deeppink",
                               "putamen" = "deeppink",
                               "neural.stem.progenitor.cell" = "deeppink",
                               "globus.pallidus" = "deeppink",
                               "astrocyte.of.the.cerebellum" = "deeppink",
                               "astrocyte" = "deeppink",
                               "inferior.parietal.cortex" = "deeppink",
                               "middle.frontal.gyrus" = "deeppink",
                               "brain.pericyte" = "deeppink",
                               "Ammon.s.horn" = "deeppink",
                               "caudate.nucleus" = "deeppink",
                               "bipolar.neuron" = "deeppink",
                               "spinal.cord" = "deeppink",
                               "superior.temporal.gyrus" = "deeppink",
                               "pons" = "deeppink",
                               "medulla.oblongata" = "deeppink",
                               "occipital.lobe" = "deeppink",
                               "midbrain" = "deeppink",
                               "T.helper.1.cell" = "darkturquoise",
                               "regulatory.T.cell" = "darkturquoise",
                               "CD4.positive..alpha.beta.T.cell" = "darkturquoise",
                               "T.cell" = "darkturquoise",
                               "natural.killer.cell" = "darkturquoise",
                               "thymus" = "darkturquoise",
                               "T.helper.2.cell" = "darkturquoise",
                               "CD4.positive.helper.T.cell" = "darkturquoise",
                               "lymphocyte.of.B.lineage...CTR...ALL" = "darkturquoise",
                               "alternatively.activated.macrophage" = "darkturquoise",
                               "monocyte...T.0days" = "darkturquoise",
                               "peripheral.blood.mononuclear.cell...AML" = "darkturquoise",
                               "macrophage...T.6days.untreated" = "darkturquoise",
                               "monocyte...T.0days" = "darkturquoise",
                               "mononuclear.cell.of.bone.marrow...AML" = "darkturquoise",
                               "macrophage...T.6days.B.glucan" = "darkturquoise",
                               "common.myeloid.progenitor..CD34.positive" = "darkturquoise",
                               "CD14.positive..CD16.negative.classical.monocyte" = "darkturquoise",
                               "erythroblast" = "darkturquoise",
                               "macrophage" = "darkturquoise",
                               "CD34.negative..CD41.positive..CD42.positive.megakaryocyte.cell" = "darkturquoise",
                               "CD14.positive.monocyte" = "darkturquoise",
                               "inflammatory.macrophage" = "darkturquoise",
                               "CD8.positive..alpha.beta.T.cell" = "darkturquoise",
                               "CD1c.positive.myeloid.dendritic.cell" = "darkturquoise",
                               "myeloid.cell...AML" = "darkturquoise",
                               "macrophage...T.6days.LPS" = "darkturquoise",
                               "B.cell" = "darkturquoise"
  ), guide="none") +
  scale_colour_manual(name='Immune Cell Types', values='red') +
  geom_hline(yintercept=-log10(0.05)) + 
  labs(title="Significant cell types associated with multiple sclerosis (FDR 0.05)", x="Cell Types", y="-log10(P-Value)") + 
  theme(axis.text.x=element_text(size=8, angle=90, hjust=1, vjust=0.3), plot.title=element_text(hjust=0.5)) +
  scale_x_discrete()
print(BHplot)
