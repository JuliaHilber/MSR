library(stringr)

load("C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\project\\data\\poiList.RData")
load("C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\project\\data\\imageList.RData")

folderPath <- "C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\div-2014\\devset\\xml\\"

monumentImageScore <- list()
for (monument in names(poiList)) {
  
  monumentData <- poiList[[monument]] # q in the cosine similarity formula
  
  # get xml file for current monument and parse ID for each image
  path <- paste(folderPath, monument,".xml", sep="")
  xml <- readLines(path)
  
  idList <- str_match_all(xml, "id=\"(\\d+)\"")
  idList <- idList[unlist(lapply(idList, nrow) != 0)]   # also matched empty lines, this function removes them
  
  imageId <- c()
  imageCosScore <- c()
  imageJacScore <- c()
  for (id in idList) {
    currentId <- id[,2]
    imageData <- imageDataList[[currentId]]  # d in the cosine similarity fomula
    
    # calculate cosine similarity
    # -> remove terms from images which are not in the baseline
    imageData <- imageData[which(imageData$terms %in% monumentData$terms),]
    tfidfsImage <- rep(0.0, length(monumentData$tfidfs))
    tfidfsImage[which(monumentData$terms %in% imageData$terms)] <- imageData$tfidfs
    innerProduct <- sum(tfidfsImage * monumentData$tfidfs)
    
    if (length(intersect(monumentData$terms, imageData$terms)) != length(imageData$terms)) {
      print('NO!')
    }
    
    cosSim <- innerProduct / sqrt(sum(tfidfsImage^2) * sum(monumentData$tfidfs^2))
    jacSim <- innerProduct / (sum(tfidfsImage^2) + sum(monumentData$tfidfs^2) - innerProduct)
    
    imageId <- c(imageId, currentId)
    imageCosScore <- c(imageCosScore, cosSim)
    imageJacScore <- c(imageJacScore, jacSim)
  }
  
  # order by score
  dataframe <- data.frame(imageId, imageCosScore, imageJacScore)
  monumentImageScore[[monument]] <- dataframe[order(-dataframe[,2], -dataframe[,3]),]

  textfile <- c(monument, monumentImageScore[1])
  write.table(textfile,
              file="C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\project\\similarityScores.txt",
              append=TRUE,
              col.names=FALSE,
              row.names=FALSE,
              quote=FALSE,
              sep=" ")  
}

save(imageDataList, file = "C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\project\\data\\similarityScores.RData")
