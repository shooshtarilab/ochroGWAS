rm(list=ls())

library(ComplexHeatmap)
library(circlize)
library(RColorBrewer)
ht_opt$TITLE_PADDING = unit(c(4.5, 4.5), "points")

#Reading csv file with adjusted p-values
ochro <- read.table("Fig1_input.csv", sep=',', header=TRUE, row.names = 1)
d1 <- data.matrix(ochro, rownames.force = TRUE)

pdf(file = "Figure_1.pdf", width=8, height=20)

#Renaming Columns 
colnames(d1)[colnames(d1) == "Graves.Disease"] <- "Grave's Disease"
colnames(d1)[colnames(d1) == "Serum.Creatinine.Levels"] <- "Serum Creatinine Levels"
colnames(d1)[colnames(d1) == "Prostate.Cancer"] <- "Prostate Cancer"
colnames(d1)[colnames(d1) == "Serum.Total.Protein.Level"] <- "Serum Total Protein Level"
colnames(d1)[colnames(d1) == "Hemoglobin.A1c.levels"] <- "Hemoglobin A1c levels"
colnames(d1)[colnames(d1) == "Red.Blood.Cell.Count"] <- "Red Blood Cell Count"
colnames(d1)[colnames(d1) == "Basophil.Count"] <- "Basophil Count"
colnames(d1)[colnames(d1) == "White.Blood.Cell.Count"] <- "White Blood Cell Count"
colnames(d1)[colnames(d1) == "Monocyte.Count"] <- "Monocyte Count"
colnames(d1)[colnames(d1) == "Mean.Corpuscular.Hemoglobin"] <- "Mean Corpuscular Hemoglobin"
colnames(d1)[colnames(d1) == "Hashimoto.Thyroiditis"] <- "Hashimoto Thyroiditis"
colnames(d1)[colnames(d1) == "Mean.Corpuscular.Volume"] <- "Mean Corpuscular Volume"
colnames(d1)[colnames(d1) == "Medication.Use.Thyroid.Preparations"] <- "Medication Use - Thyroid Preparations"
colnames(d1)[colnames(d1) == "Hypothyroidism"] <- "Hypothyroidism"
colnames(d1)[colnames(d1) == "Lymphocyte.Counts.1"] <- "Lymphocyte Counts"
colnames(d1)[colnames(d1) == "Platelet.Count"] <- "Platelet Count"
colnames(d1)[colnames(d1) == "Eosinophil.Counts"] <- "Eosinophil Counts"
colnames(d1)[colnames(d1) == "Mean.Corpuscular.Hemoglobin.Concentration"] <- "Mean Corpuscular Hemoglobin Concentration"
colnames(d1)[colnames(d1) == "Atopic.Dermatitis"] <- "Atopic Dermatitis"
colnames(d1)[colnames(d1) == "Insomnia"] <- "Insomnia"
colnames(d1)[colnames(d1) == "Uterine.Fibroids"] <- "Uterine Fibroids"
colnames(d1)[colnames(d1) == "Body.Mass.Index"] <- "Body Mass Index"

hm <- Heatmap(d1,
              #Impart solid colors in 0.0 - 0.05 (dark red), 0.05-0.10 (tomato) and gradient from 0.10 to 1.00 (wheat --> light yellow)
              col = colorRamp2(c(0, 0.05, 0.05001, 0.1, 0.10001, 1), c("darkred","darkred","tomato", "tomato","wheat","lightyellow")),
              cluster_rows = TRUE,
              cluster_columns = TRUE,
              column_title = "GWAS",
              border = TRUE,
              column_title_gp = gpar(fill="light blue", col="black", fontsize = 12.5, fontface = "bold"),
              row_title = "CELL TYPES",
              row_title_gp = gpar(fill="light blue", col="black", fontsize = 12.5, fontface = "bold"),
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

