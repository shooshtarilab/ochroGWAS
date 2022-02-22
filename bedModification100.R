# change the directory to point to all files that need to be modded. Make sure working directory is NOT in that same directory
path <- ""
files <- list.files(path=path, pattern="*.bed", full.names = TRUE, recursive = FALSE)

compiled <- data.frame(ChrNum=integer(), Start=integer(), End=integer())

# iterate through the listed bed files in given directory
for (cell in files){
  check <- TRUE
  
  # process each file
  if (check){
    print(c("Processing", cell))
    # data frame creation for ONE cell
    fileData <- read.table(cell, header=FALSE, sep="\t", quote="")
    # rename column names
    colnames(fileData) <- c("ChrNum", "Start", "End")
    
    # make modifications to each read
    fileData[,"Start"] <- fileData[,"Start"] - 100
    fileData[,"End"] <- fileData[,"End"] + 100
    write.table(fileData, basename(cell), sep = "\t", col.names = FALSE, row.names = FALSE, quote = FALSE, append = FALSE)
  }
  
}

