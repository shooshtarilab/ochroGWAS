rm(list=ls())

library(ComplexHeatmap)
library(circlize)
library(RColorBrewer)
ht_opt$TITLE_PADDING = unit(c(4.5, 4.5), "points")

#Single-Cell Data with Rows manually Sorted 
sc <- read.table("Figure2.csv", sep=',', header=TRUE, row.names = 1)
d1 <- data.matrix(sc, rownames.force = TRUE)

#Renaming Columns

colnames(d1)[colnames(d1) == "Graves.Disease"] <- "Grave's Disease"
colnames(d1)[colnames(d1) == "Head.Injury"] <- "Head Injury"
colnames(d1)[colnames(d1) == "Lymphocyte.Counts"] <- "Lymphocyte Counts"
colnames(d1)[colnames(d1) == "Eosinophil.Counts"] <- "Eosinophil Counts"
colnames(d1)[colnames(d1) == "MedicationUseThyroidPreparation"] <- "Medication Use - Thyroid Preparation"
colnames(d1)[colnames(d1) == "Hypothyroidism"] <- "Hypothyroidism"
colnames(d1)[colnames(d1) == "HashimotoThyroiditis"] <- "Hashimoto Thyroiditis"
colnames(d1)[colnames(d1) == "PediatricAsthma"] <- "Pediatric Asthma"
colnames(d1)[colnames(d1) == "MedicationUseGlucocorticoids"] <- "Medication Use - Glucocorticoids"
colnames(d1)[colnames(d1) == "MedicationUseAdrenergicsInhalants"] <- "Medication Use - Adrenergics Inhalants"
colnames(d1)[colnames(d1) == "AtopicDermatitis"] <- "Atopic Dermatitis"
colnames(d1)[colnames(d1) == "BasophilCount"] <- "Basophil Count"
colnames(d1)[colnames(d1) == "MonocyteCount"] <- "Monocyte Count"
colnames(d1)[colnames(d1) == "AspartateAminotransferaseLevels"] <- "Aspartate Aminotransferase Levels"
colnames(d1)[colnames(d1) == "AcuteGlomeruloNephritis"] <- "AcuteGlomerulo Nephritis"
colnames(d1)[colnames(d1) == "CerebralAneurysm"] <- "Cerebral Aneurysm"
colnames(d1)[colnames(d1) == "SystolicBloodPressure"] <- "Systolic Blood Pressure"
colnames(d1)[colnames(d1) == "MeanArterialPressure"] <- "Mean Arterial Pressure"
colnames(d1)[colnames(d1) == "PulmonaryFibrosis"] <- "Pulmonary Fibrosis"
colnames(d1)[colnames(d1) == "Pleurisy"] <- "Pleurisy"
colnames(d1)[colnames(d1) == "ChronicHepatitisCInfection"] <- "Chronic Hepatitis C Infection"
colnames(d1)[colnames(d1) == "MeanCorpuscularHemoglobin"] <- "Mean Corpuscular Hemoglobin"
colnames(d1)[colnames(d1) == "MeanCorpuscularHemoglobinConcentration"] <- "Mean Corpuscular Hemoglobin Concentration"
colnames(d1)[colnames(d1) == "MeanCorpuscularVolume"] <- "Mean Corpuscular Volume"
colnames(d1)[colnames(d1) == "RedBloodCellCount"] <- "Red Blood Cell Count"
colnames(d1)[colnames(d1) == "Hemoglobin"] <- "Hemoglobin"
colnames(d1)[colnames(d1) == "HemoglobinA1cLevels"] <- "Hemoglobin A1c Levels"
colnames(d1)[colnames(d1) == "PlateletCount"] <- "Platelet Count"
colnames(d1)[colnames(d1) == "ChronicHeartFailure"] <- "Chronic Heart Failure"
colnames(d1)[colnames(d1) == "MedicationUseAgentsActingOnTheReninAngiotensinSystem"] <- "Medication Use - Renin Angiotensin System"
colnames(d1)[colnames(d1) == "UnstableAnginaPectoris"] <- "Unstable Angina Pectoris"
colnames(d1)[colnames(d1) == "StableAnginaPectoris"] <- "Stable Angina Pectoris"
colnames(d1)[colnames(d1) == "MyocardialInfarction"] <- "Myocardial Infarction"
colnames(d1)[colnames(d1) == "DiastolicBloodPressure"] <- "Diastolic Blood Pressure"
colnames(d1)[colnames(d1) == "Height"] <- "Height"
colnames(d1)[colnames(d1) == "CompressionFracture"] <- "Compression Fracture"
colnames(d1)[colnames(d1) == "StevensJohnsonSyndrome"] <- "Stevens Johnson Syndrome"
colnames(d1)[colnames(d1) == "CesarianSection"] <- "Cesarian Section"
colnames(d1)[colnames(d1) == "GastricCancer"] <- "Gastric Cancer"
colnames(d1)[colnames(d1) == "BreastCancer"] <- "Breast Cancer"
colnames(d1)[colnames(d1) == "BloodUreaNitrogenLevels"] <- "Blood Urea Nitrogen Levels"
colnames(d1)[colnames(d1) == "SerumCreatinineLevels"] <- "Serum Creatinine Levels"
colnames(d1)[colnames(d1) == "ProstateCancer"] <- "Prostate Cancer"
colnames(d1)[colnames(d1) == "GammaGlutamylTranspeptidase"] <- "Gamma Glutamyl Transpeptidase"
colnames(d1)[colnames(d1) == "CalciumLevels"] <- "Calcium Levels"
colnames(d1)[colnames(d1) == "SerumUricAcidLevels"] <- "Serum Uric Acid Levels"
colnames(d1)[colnames(d1) == "Type1Diabetes"] <- "Type 1 Diabetes"
colnames(d1)[colnames(d1) == "Type2Diabetes"] <- "Type 2 Diabetes"
colnames(d1)[colnames(d1) == "GlucoseLevels"] <- "Glucose Levels"
colnames(d1)[colnames(d1) == "MedicationUseDrugsUsedInDiabetes"] <- "Medication Use Drugs Diabetes"
colnames(d1)[colnames(d1) == "ChronicPancreatitis"] <- "Chronic Pancreatitis"
colnames(d1)[colnames(d1) == "PolycysticKidneyDisease"] <- "Polycystic Kidney Disease"
colnames(d1)[colnames(d1) == "BodyMassIndex"] <- "Body Mass Index"
colnames(d1)[colnames(d1) == "BackPain"] <- "Back Pain"
colnames(d1)[colnames(d1) == "MedicationUseAntiInflammatoryAndAntiRheumaticProductsNonSteroids"] <- "Medication Use - AntiInflammatory & AntiRheumatic"
colnames(d1)[colnames(d1) == "PulsePressure"] <- "Pulse Pressure"
colnames(d1)[colnames(d1) == "MedicationUseCalciumChannelBlockers"] <- "Medication Use - Calcium Channel Blockers"
colnames(d1)[colnames(d1) == "AlanineAminotransferaseLevels"] <- "Alanine Aminotransferase Levels"
colnames(d1)[colnames(d1) == "TotalCholestrolLevels"] <- "Total Cholestrol Levels"


png(file = "Figure2.png", height=35000, width= 14000, res=1200)

hm <- Heatmap(d1,
              col = colorRamp2(c(0, 0.05, 0.05001, 0.1, 0.10001, 1), c("darkred","darkred","tomato", "tomato","wheat", "lightyellow")),
              cluster_rows = FALSE,
              cluster_columns = FALSE,
              column_title = "GWAS",
              column_title_gp = gpar(fill="light blue", col="black", fontsize = 12.5, fontface = "bold"),
              row_title = "CELL TYPES",
              row_title_gp = gpar(fill="light blue", col="black", fontsize = 12.5, fontface = "bold"),
              
              #For Annotations, skipped color numbers to avoid black
              right_annotation = rowAnnotation(foo = anno_block(gp = gpar(fill = c(16,2,3,4,5,6,7,8,20,10,11,12,13,14,15)),
                                                       labels = c("Immune Cells", "Endothelial Cells", "Erythroids",
                                                                  "Cardio", "Stromal Cells", "Adult Stromal Cells",
                                                                  "Skeletal Myo", "F&P", "Epithelial",
                                                                  "Gastric and GI Epithelial", "Islets", "Fetal Neural",
                                                                  "Neural", "A. Cortical", "Hepa"),
                                                       labels_gp = gpar(col = "black", fontsize = 8))),
              cluster_row_slices = FALSE,
              cluster_column_slices = FALSE,
              row_split = factor(c(rep("Immune", 27), 
                            rep("Endothelial", 17),
                            rep("Erythroids", 5),
                            rep("Cardiomyocytes", 4),
                            rep("Stromal", 26),
                            rep("Adult Stromal", 22),
                            rep("Skeletal Myocyte", 7),
                            rep("Follicular and Placental", 3),
                            rep("Epithelial", 28),
                            rep("Gastric and GI Epithelial", 19),
                            rep("Islets", 8),
                            rep("Fetal Neural", 25),
                            rep("Neural", 22),
                            rep("Adrenal Cortical", 6),
                            rep("Hepatocytes", 3)), levels =  c("Immune", "Endothelial", "Erythroids",
                                                                "Cardiomyocytes", "Stromal", "Adult Stromal",
                                                                "Skeletal Myocyte", "Follicular and Placental", "Epithelial",
                                                                "Gastric and GI Epithelial", "Islets", "Fetal Neural",
                                                                "Neural", "Adrenal Cortical", "Hepatocytes")),
                            

              show_row_dend = FALSE,
              show_column_dend = FALSE,
              row_names_gp = gpar(fontsize = 7), #change word size for row names
              row_names_max_width = max_text_width(  #shows complete row names
                rownames(d1), 
                gp = gpar(fontsize = 12)),
            
              column_names_gp = gpar(fontsize = 7),
              rect_gp = gpar(col = "white", lwd = 0.1), #grid lines

              heatmap_legend_param = list(title = "FDR P-val", border="black", at=c(0,0.05,0.1,1), legend_height=unit(5,"cm"),title_position = "leftcenter-rot")
              )
draw(hm, heatmap_legend_side = "left")
dev.off()

