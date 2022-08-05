rm(list=ls())

library(ComplexHeatmap)
library(circlize)
library(RColorBrewer)
ht_opt$TITLE_PADDING = unit(c(4.5, 4.5), "points")

# data <- read.table("ImmuneCells.csv", sep=',', header=TRUE, row.names = 1)
# d <- data.matrix(data, rownames.force = TRUE)
# d <- t(d)


# Heatmap(d, row_names_side = "right",
#         cluster_rows = TRUE,
#         cluster_columns = TRUE,
#         #rect_gp = gpar(col = "white", lwd = 1),
#         col = col_fun,
#         #col = rev(RColorBrewer::brewer.pal(name = "Blues", n = 3)),
#         cell_fun = function(j, i, x, y, width, height, fill) {
#           if(d[i,j] <= 0.05 && d[i,j]>0.01)
#             grid.text(sprintf("*", d[i, j]), x, y, gp = gpar(fontsize = 15))
#           if(d[i,j] <= 0.01)
#             grid.text(sprintf("**", d[i, j]), x, y, gp = gpar(fontsize = 15))})



adult <- read.table("Combined_1.csv", sep=',', header=TRUE, row.names = 1)
d1 <- data.matrix(adult, rownames.force = TRUE)

#final_d = d1

col_fun = colorRamp2(c(0, 0.04, 0.05, 1), c("red", "red", "pink", "white"))
lgd = Legend(col_fun = col_fun, title = "foo")
pdf(file = "C:/Users/akash/Downloads/test.pdf", width=50, height=40)

H1 <- Heatmap(d1, row_names_side = "right",
              cluster_rows = TRUE, 
              cluster_columns = TRUE, 
              rect_gp = gpar(col = "white", lwd = 1), 
              col = col_fun,
              border = TRUE,
              #border_gp = gpar(lwd=2, lty=2),
              #col = rev(RColorBrewer::brewer.pal(name = "Blues", n = 3)),
              #column_title = "GWAS",
              #column_title_gp = gpar(fill="light blue", col="black", fontsize = 13, fontface = "bold"),
              #row_title = "CELL TYPES",
              #row_title_gp = gpar(fill="light blue", col="black", fontsize = 16, fontface = "bold"),
              show_column_dend = FALSE, show_row_dend = FALSE,
              heatmap_legend_param = list(title = "FDR P-val", border="black", at=c(0,0.05,1), legend_height=unit(25,"cm"),title_position = "leftcenter-rot"),
              cell_fun = function(j, i, x, y, width, height, fill) {
                if(d1[i,j] <= 0.05 && d1[i,j]>0.01)
                  grid.text(sprintf("*", d1[i, j]), x, y, gp = gpar(fontsize = 7))
                if(d1[i,j] <= 0.01)
                  grid.text(sprintf("**", d1[i, j]), x, y, gp = gpar(fontsize = 7))})

# # colors EF3B2C, 2171b5
# H2 <- Heatmap(d2, row_names_side = "right",
#               cluster_rows = FALSE, 
#               cluster_columns = TRUE, 
#               show_column_dend = FALSE, show_row_dend = FALSE,
#               column_title = "FETAL CELL TYPES",
#               column_title_gp = gpar(fill="light blue", col="black", fontsize = 13, fontface = "bold"),
#               rect_gp = gpar(col = "white", lwd = 1), 
#               #col = col_fun,
#               col = colorRamp2(c(0, 1), c("#EF3B2C", "white")),
#               show_heatmap_legend = FALSE,
#               border = TRUE,
#               #heatmap_legend_param = list(title = "FDR P-val", border="black", at=c(0,0.05,1), legend_height=unit(5,"cm"),title_position = "leftcenter-rot"),
#               #col = rev(RColorBrewer::brewer.pal(name = "Blues", n = 3)),
#               cell_fun = function(j, i, x, y, width, height, fill) {
#                 if(d2[i,j] <= 0.05 && d2[i,j]>0.01)
#                   grid.text(sprintf("*", d2[i, j]), x, y, gp = gpar(fontsize = 12))
#                 if(d2[i,j] <= 0.01)
#                   grid.text(sprintf("**", d2[i, j]), x, y, gp = gpar(fontsize = 12))})

htlist <- H1

draw(htlist, heatmap_legend_side = "left")
dev.off()
