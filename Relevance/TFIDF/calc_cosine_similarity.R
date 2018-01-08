library(stringr)

load("/Users/Julia/Documents/Universität/MultimediaSearchAndRetrieval/Projekt/MSR/Relevance/TFIDF/data/poiList.RData")
load("/Users/Julia/Documents/Universität/MultimediaSearchAndRetrieval/Projekt/MSR/Relevance/TFIDF/data/imageList.RData")
load("/Users/Julia/Documents/Universität/MultimediaSearchAndRetrieval/Projekt/MSR/Relevance/Preprocessing/preprocessed_result.RData")

monumentImageScore <- list()
for (monument in names(poiList)) {
  
  monumentData <- poiList[[monument]] # q in the cosine similarity formula
  
  # get xml file for current monument and parse ID for each image
  #path <- paste(folderPath, monument,".xml", sep="")
  #xml <- readLines(path)
  
  idList <- noFaceDetected[noFaceDetected[,1]==monument,2]
  #idList <- str_match_all(xml, "id=\"(\\d+)\"")
  #idList <- idList[unlist(lapply(idList, nrow) != 0)]   # also matched empty lines, this function removes them
  
  imageId <- c()
  imageCosScore <- c()
  imageJacScore <- c()
  for (id in idList) {
    currentId <- toString(id)
    imageData <- imageDataList[[currentId]]  # d in the cosine similarity fomula
    
    # calculate cosine similarity
    # (remove terms from images which are not in the baseline)
    imageData <- imageData[which(imageData$terms %in% monumentData$terms),]
    tfidfsImage <- rep(0.0, length(monumentData$tfidfs))
    tfidfsImage[which(monumentData$terms %in% imageData$terms)] <- imageData$tfidfs
    innerProduct <- sum(tfidfsImage * monumentData$tfidfs)
    
    cosSim <- innerProduct / sqrt(sum(tfidfsImage^2) * sum(monumentData$tfidfs^2))
    jacSim <- innerProduct / (sum(tfidfsImage^2) + sum(monumentData$tfidfs^2) - innerProduct)
    
    imageId <- c(imageId, currentId)
    imageCosScore <- c(imageCosScore, cosSim)
    imageJacScore <- c(imageJacScore, jacSim)
  }
  
  # order by score
  dataframe <- data.frame(imageId, imageCosScore, imageJacScore)
  monumentImageScore[[monument]] <- dataframe[order(-dataframe[,2], -dataframe[,3]),]

  textfile <- c(monument, monumentImageScore[[monument]])
  write.table(textfile,
              file="/Users/Julia/Documents/Universität/MultimediaSearchAndRetrieval/Projekt/MSR/Relevance/TFIDF/similarityScores.txt",
              append=TRUE,
              col.names=FALSE,
              row.names=FALSE,
              quote=FALSE,
              sep=" ")  
}

save(imageDataList, file = "/Users/Julia/Documents/Universität/MultimediaSearchAndRetrieval/Projekt/MSR/Relevance/TFIDF/data/similarityScores.RData")
