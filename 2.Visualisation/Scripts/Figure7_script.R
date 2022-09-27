library(ggplot2)
library(cowplot)

#Un-comment Cells/Peaks section to run that script. The custom order is such that peaks are sorted in increasing order.

#To Create Peaks Map --->


data_peaks <- read.table("Figure7_input_peaks.csv", sep=',', header=TRUE)
colnames(data_peaks)[colnames(data_peaks) == "Cell"] <- "Categories"

data_peaks$Categories <- factor(data_peaks$Categories, levels= c('Erythroids', 'Fetal Neural Cells', 'Immune Cells', 'Skeletal Myocytes', 'Neural Cells', 'Endothelial Cells',
                                                     'Adult Stromal Cells', 'Gastric and GI Epithelial', 'Stromal Cells', 'Epithelial', 'Adrenal Cortical',
                                                     'Islets and Neuroendocrine', 'Hepatocyte', 'Cardiomyocytes', 'Follicular and Placental'))

#png(file = "Figure7_peaks.png", width = 40, height = 30, units = 'cm', res = 600)
box.plot1 <- ggplot(data_peaks,
                    aes(
                      x=Categories,
                      y=Peaks,
                      fill=Categories))+ 
                      labs(x ="Categories of Cell Types", y = "Number of Peaks") +
  geom_boxplot(color="darkblue", fill="skyblue", width=0.6, outlier.size = 0.1) + 
  scale_y_continuous(labels = scales::comma) +
  theme_light()+ theme(text = element_text(size = 35), axis.text.x = element_text(angle = 60, vjust = 1, hjust = 1))
box.plot1
#dev.off()


#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#For Number of Cells -->

data_nuclei <- read.table("Figure7_input_nuclei.csv", sep=',', header=TRUE)
colnames(data_nuclei)[colnames(data_nuclei) == "Cell"] <- "Categories"

data_nuclei$Categories <- factor(data_nuclei$Categories, levels= c('Erythroids', 'Fetal Neural Cells', 'Immune Cells', 'Skeletal Myocytes', 'Neural Cells', 'Endothelial Cells',
                                                     'Adult Stromal Cells', 'Gastric and GI Epithelial', 'Stromal Cells', 'Epithelial', 'Adrenal Cortical',
                                                     'Islets and Neuroendocrine', 'Hepatocyte', 'Cardiomyocytes', 'Follicular and Placental'))

#png(file = "Figure7_nuclei.png", width = 40, height = 30, units = 'cm', res = 600)
box.plot2 <- ggplot(data_nuclei,
                    aes(
                      x=Categories,
                      y=Nuclei.Count,
                      fill=Categories))+ labs(x ="Categories of Cell Types", y = "Number of Nuclei") +
  geom_boxplot(color="darkblue", fill="skyblue", width=0.6, outlier.size = 0.1) + 
  scale_y_continuous(labels = scales::comma) +
  theme_light()+ theme(text = element_text(size = 35), axis.text.x = element_text(angle = 60, vjust = 1, hjust = 1))
box.plot2
#dev.off()

png(file = "Figure7.png", width = 70, height = 40, units = 'cm', res = 600)
plot_grid(box.plot1, box.plot2, labels= c("A", "B"), label_size = 30, align = "hv", ncol=2, nrow = 1)
dev.off()
