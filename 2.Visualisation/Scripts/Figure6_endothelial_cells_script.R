rm(list=ls())

library(ComplexHeatmap)
library(circlize)
library(RColorBrewer)
ht_opt$TITLE_PADDING = unit(c(4.5, 4.5), "points")

adult <- read.table("Figure6_endothelial_cells_adult.csv", sep=',', header=TRUE, row.names = 1)  
d1 <- data.matrix(adult, rownames.force = TRUE)
fetal <- read.table("Figure6_endothelial_cells_fetal.csv", sep=',', header=TRUE, row.names = 1)  
d2 <- data.matrix(fetal, rownames.force = TRUE)

#Renaming Columns

colnames(d2)[colnames(d2) == "Red.Blood.Cell.Count"] <- "Red Blood Cell Count"
colnames(d2)[colnames(d2) == "Mean.Corpuscular.Hemoglobin"] <- "Mean Corpuscular Hemoglobin"
colnames(d2)[colnames(d2) == "Mean.Corpuscular.Hemoglobin.Concentration"] <- "Mean Corpuscular Hemoglobin Concentration"
colnames(d2)[colnames(d2) == "Mean.Corpuscular.Volume"] <- "Mean Corpuscular Volume"
colnames(d2)[colnames(d2) == "Platelet.Count"] <- "Platelet Count"
colnames(d2)[colnames(d2) == "Chronic.Hepatitis.C.Infection"] <- "Chronic Hepatitis C Infection"
colnames(d2)[colnames(d2) == "Pleurisy"] <- "Pleurisy"
colnames(d2)[colnames(d2) == "Pulmonary.Fibrosis"] <- "Pulmonary Fibrosis"
colnames(d2)[colnames(d2) == "Mean.Arterial.Pressure"] <- "Mean Arterial Pressure"
colnames(d2)[colnames(d2) == "Systolic.Blood.Pressure"] <- "Systolic Blood Pressure"
colnames(d2)[colnames(d2) == "Myocardial.Infarction"] <- "Myocardial Infarctions"
colnames(d2)[colnames(d2) == "Diastolic.Blood.Pressure"] <- "Diastolic Blood Pressure"
colnames(d2)[colnames(d2) == "Height"] <- "Height"
colnames(d2)[colnames(d2) == "Cerebral.Aneurysm"] <- "Cerebral Aneurysm"

#Transposing for Heatmaps

d1 = t(d1)
d2 = t(d2)

#Output
png("Figure6.png", width=3500, height=1700, res=300)

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
