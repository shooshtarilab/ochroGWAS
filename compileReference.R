# include path to list of bed files
path <- ""
files <- list.files(path=path, pattern="*.bed", full.names = TRUE, recursive = FALSE)

# list only for excluding certain cell types from the compilation
cellLineNames <- c("HepG2","Daoy","SJSA1","LNCaP.clone.FGC","G401","HCT116","L1.S8","ACHN","Panc1","SW480","RCC.7860","IMR.90","MM.1S","EL","L1.S8R","HS.27A","WERI.Rb.1","HFF.Myc","K562","Jurkat.clone.E61","KBM.7","SK.N.MC","ELF.1","HL.60","NAMALWA","HAP.1","MCF.7","HeLa.S3","H4","A549","HS.5","SK.N.DZ","LoVo","A673","A172","CMK","NT2.D1","SK.N.SH","WI38","Caki2","ELR","MG63","SJCRH30","PC.3","OCI.LY7","GM06990","Caco.2","EH","GM12878","RKO","RPMI8226","HT.29","NCI.H226","PC.9","Karpas.422","GM12864","BE2C")

compiled <- data.frame(ChrNum=integer(), Start=integer(), End=integer())

for (cell in files){
  check <- TRUE
  
  # iterate through cell lines in cell line list, skip inclusion of cell lines
  # for (cancer in cellLineNames){
    # if file name is found in cell line, skip
    # if (grepl(cancer, cell, fixed = TRUE)){
      # print(c("Skipping", cell))
      # check <- FALSE
    # }
  # }
  
  # if file is not a cell line, then continue. else, next loop
  if (check){
    print(c("Processing", cell))
    # data frame creation for ONE cell
    addCompiled <- read.table(cell, header=FALSE, sep="\t", quote="")
    # rename column names
    colnames(addCompiled) <- c("ChrNum", "Start", "End")
    
    # for each row in the dataframe for cell
    # make modifications to each read
    addCompiled[,"Start"] <- addCompiled[,"Start"] - 100
    addCompiled[,"End"] <- addCompiled[,"End"] + 100
    write.table(addCompiled, "compiledReference.bed", sep = "\t", col.names = FALSE, row.names = FALSE, quote = FALSE, append = TRUE)
  }
  
}
compiledAll <- read.table("compiledReference.bed", header=FALSE, sep="\t", quote="")

uniqueCompiled <- compiledAll[!duplicated(compiledAll),]

write.table(uniqueCompiled, "uniqueCompiledReference.bed", sep = "\t", col.names = FALSE, row.names = FALSE, quote = FALSE)