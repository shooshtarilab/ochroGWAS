library(ggplot2)

#Un-comment Cells/Peaks section to run that script. The custom order is such that peaks are sorted in increasing order.

#png(file = "Figure7_peaks.png", width=25, height=25)

#To Create Peaks Map --->


# data <- read.table("Figure7_input_peaks.csv", sep=',', header=TRUE)
# colnames(data)[colnames(data) == "ï..Cell"] <- "Categories"
# 
# data$Categories <- factor(data$Categories, levels= c('Erythroids', 'Fetal Neural Cells', 'Immune Cells', 'Skeletal Myocytes', 'Neural Cells', 'Endothelial Cells',
#                                                      'Adult Stromal Cells', 'Gastric and GI Epithelial', 'Stromal Cells', 'Epithelial', 'Adrenal Cortical',
#                                                      'Islets and Neuroendocrine', 'Hepatocyte', 'Cardiomyocytes', 'Follicular and Placental'))
# box.plot1 <- ggplot(data,
#                     aes(
#                       x=Categories,
#                       y=Peaks,
#                       fill=Categories))+ labs(x ="Categories of Cell Types", y = "Number of Peaks") +
#   geom_boxplot(width=0.6) + theme_light()+ theme(text = element_text(size = 35), axis.text.x = element_text(angle = 60, vjust = 1, hjust = 1))
# box.plot1
# dev.off()
# 

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#For Number of Cells -->

# data <- read.table("Figure7_input_nuclei.csv", sep=',', header=TRUE)
# colnames(data)[colnames(data) == "ï..Cell"] <- "Categories"
# 
# png(file = "Figure7_nuclei.png", width=25, height=25)
# data$Categories <- factor(data$Categories, levels= c('Erythroids', 'Fetal Neural Cells', 'Immune Cells', 'Skeletal Myocytes', 'Neural Cells', 'Endothelial Cells',
#                                                      'Adult Stromal Cells', 'Gastric and GI Epithelial', 'Stromal Cells', 'Epithelial', 'Adrenal Cortical',
#                                                      'Islets and Neuroendocrine', 'Hepatocyte', 'Cardiomyocytes', 'Follicular and Placental'))
# box.plot1 <- ggplot(data,
#                     aes(
#                       x=Categories,
#                       y=Nuclei.Count,
#                       fill=Categories))+ labs(x ="Categories of Cell Types", y = "Number of Nuclei") +
#   geom_boxplot(width=0.6) + theme_light()+ theme(text = element_text(size = 35), axis.text.x = element_text(angle = 60, vjust = 1, hjust = 1))
# box.plot1
# dev.off()
