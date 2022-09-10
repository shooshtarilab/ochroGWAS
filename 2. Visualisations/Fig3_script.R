# This script can be used to generate heatmaps for Figure 3 to Figure 6 and Figure S1 to Figure S11 with a few modifications:
# (a) Consider if both Adult.csv andd Fetal.csv is required or just one of them
# (b) Rename the columns according to the CSV files taken. 
# (c) Rename output figure.

rm(list=ls())

library(ComplexHeatmap)
library(circlize)
library(RColorBrewer)
ht_opt$TITLE_PADDING = unit(c(4.5, 4.5), "points")

#All Single-Cell Categories have two csv files, Adult.csv and Fetal.csv

adult <- read.table("Adult.csv", sep=',', header=TRUE, row.names = 1)
d1 <- data.matrix(adult, rownames.force = TRUE)
fetal <- read.table("Fetal.csv", sep=',', header=TRUE, row.names = 1)
d2 <- data.matrix(fetal, rownames.force = TRUE)

#Renaming Columns for Immune Cells, similarly for all other

colnames(d2)[colnames(d2) == "Red.Blood.Cell.Count"] <- "Red Blood Cell Count"
colnames(d2)[colnames(d2) == "Mean.Corpuscular.Hemoglobin"] <- "Mean Corpuscular Hemoglobin"
colnames(d2)[colnames(d2) == "Mean.Corpuscular.Hemoglobin.Concentration"] <- "Mean Corpuscular Hemoglobin Concentration"
colnames(d2)[colnames(d2) == "Mean.Corpuscular.Volume"] <- "Mean Corpuscular Volume"
colnames(d2)[colnames(d2) == "Platelet.Count"] <- "Platelet Count"
colnames(d2)[colnames(d2) == "Acute.Glomerulo.Nephritis"] <- "Acute Glomerulo Nephritis"
colnames(d2)[colnames(d2) == "Aspartate.Aminotransferase.Levels"] <- "Aspartate Aminotransferase Levels"
colnames(d2)[colnames(d2) == "Monocyte.Count"] <- "Monocyte Count"
colnames(d2)[colnames(d2) == "Basophil.Count"] <- "Basophil Count"
colnames(d2)[colnames(d2) == "Hemoglobin.A1c.Levels"] <- "Hemoglobin A1c Levels"
colnames(d2)[colnames(d2) == "Atopic.Dermatitis"] <- "Atopic Dermatitis"
colnames(d2)[colnames(d2) == "Medication.Use.Adrenergics.Inhalants"] <- "Medication Use Adrenergics Inhalants"
colnames(d2)[colnames(d2) == "Medication.Use.Glucocorticoids"] <- "Medication Use Glucocorticoids"
colnames(d2)[colnames(d2) == "Pediatric.Asthma"] <- "Pediatric Asthma"
colnames(d2)[colnames(d2) == "Hashimoto.Thyroiditis"] <- "Hashimoto Thyroiditis"
colnames(d2)[colnames(d2) == "Medication.Use.Thyroid.Preparation"] <- "Medication Use Thyroid Preparation"
colnames(d2)[colnames(d2) == "Eosinophil.Counts"] <- "Eosinophil Counts"
colnames(d2)[colnames(d2) == "Lymphocyte.Counts"] <- "Lymphocyte Counts"
colnames(d2)[colnames(d2) == "Head.Injury"] <- "Head Injury"
colnames(d2)[colnames(d2) == "Graves.Disease"] <- "Graves Disease"

#Transposing for Heatmaps

d1 = t(d1)
d2 = t(d2)

pdf(file = "Figure_3.pdf", width=11, height=6.5)

#Colour gradient
col_fun = colorRamp2(c(0, 1), c("#EF3B2C", "white"))

#Adult Heatmap 
H1 <- Heatmap(d1, row_names_side = "right",
              cluster_rows = TRUE, 
              cluster_columns = TRUE, 
              rect_gp = gpar(col = "white", lwd = 1), 
              col = col_fun,
              border = TRUE,
              column_names_rot = 60,
              row_names_gp = grid::gpar(fontsize = 8),
              column_names_gp = grid::gpar(fontsize = 8),
              column_title = "ADULT CELL TYPES",
              column_title_gp = gpar(fill="light blue", col="black", fontsize = 10, fontface = "bold"),
              row_title = "GWAS",
              row_title_gp = gpar(fill="light blue", col="black", fontsize = 12, fontface = "bold"),
              show_column_dend = FALSE, show_row_dend = FALSE,
              heatmap_legend_param = list(title = "FDR P-val", border="black", at=c(0,0.05,1), legend_height=unit(5,"cm"),title_position = "leftcenter-rot"),
              cell_fun = function(j, i, x, y, width, height, fill) {
                if(d1[i,j] <= 0.05 && d1[i,j]>0.01)
                  grid.text(sprintf("*", d1[i, j]), x, y, gp = gpar(fontsize = 12))
                if(d1[i,j] <= 0.01)
                  grid.text(sprintf("**", d1[i, j]), x, y, gp = gpar(fontsize = 12))})

#Fetal Heatmap
H2 <- Heatmap(d2, row_names_side = "right",
              cluster_rows = TRUE, 
              cluster_columns = TRUE, 
              show_column_dend = FALSE, show_row_dend = FALSE,
              column_title = "FETAL CELL TYPES",
              column_title_gp = gpar(fill="light blue", col="black", fontsize = 10, fontface = "bold"),
              rect_gp = gpar(col = "white", lwd = 1), 
              col = col_fun,
              row_names_gp = grid::gpar(fontsize = 8),
              column_names_gp = grid::gpar(fontsize = 8),
              show_heatmap_legend = FALSE,  #Both adult have same color gradient, so two legends not required
              border = TRUE,
              column_names_rot = 60,
              cell_fun = function(j, i, x, y, width, height, fill) {
                if(d2[i,j] <= 0.05 && d2[i,j]>0.01)
                  grid.text(sprintf("*", d2[i, j]), x, y, gp = gpar(fontsize = 12))
                if(d2[i,j] <= 0.01)
                  grid.text(sprintf("**", d2[i, j]), x, y, gp = gpar(fontsize = 12))})

htlist <- H1+H2

draw(htlist, heatmap_legend_side = "left")
dev.off()
