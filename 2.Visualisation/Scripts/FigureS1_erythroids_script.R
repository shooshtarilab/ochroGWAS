rm(list=ls())

library(ComplexHeatmap)
library(circlize)
library(RColorBrewer)
ht_opt$TITLE_PADDING = unit(c(4.5, 4.5), "points")

fetal <- read.table("FigureS1_erythroids_fetal.csv", sep=',', header=TRUE, row.names = 1)    
d2 <- data.matrix(fetal, rownames.force = TRUE)

#Renaming Columns

colnames(d2)[colnames(d2) == "Red.Blood.Cell.Count"] <- "Red Blood Cell Count"
colnames(d2)[colnames(d2) == "Mean.Corpuscular.Hemoglobin"] <- "Mean Corpuscular Hemoglobin"
colnames(d2)[colnames(d2) == "Mean.Corpuscular.Hemoglobin.Concentration"] <- "Mean Corpuscular Hemoglobin Concentration"
colnames(d2)[colnames(d2) == "Mean.Corpuscular.Volume"] <- "Mean Corpuscular Volume"
colnames(d2)[colnames(d2) == "Platelet.Count"] <- "Platelet Count"
colnames(d2)[colnames(d2) == "Hemoglobin"] <- "Hemoglobin"
colnames(d2)[colnames(d2) == "Hemoglobin.A1c.Levels"] <- "Hemoglobin A1c Levels"

#Transposing for Heatmaps

d1 = t(d2)

#Output
png("Figure3.png", res=300, height=1500, width=2500)

#Colour gradient
col_fun = colorRamp2(c(0, 1), c("#EF3B2C", "white"))

#Fetal Heatmap 
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


htlist <- H1

draw(htlist, heatmap_legend_side = "left")
dev.off()
