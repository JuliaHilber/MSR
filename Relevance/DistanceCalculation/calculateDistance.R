load("C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\project\\MSR\\Relevance\\TFIDF\\data\\poiList.RData")
load("C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\project\\MSR\\Relevance\\Preprocessing\\preprocessed_result.RData")

enum <- c("CM", "CM3x3", "CN", "CN3x3", "CSD", "GLRLM", "GLRLM3x3", "HOG", "LBP", "LBP3x3")

# help function to normalize the data from 0 to 1
normalization <- function(x){(x-min(x))/(max(x)-min(x))}

# calculate centroid per location
monumentCentroids <- c()
for (monument in names(poiList)) {
  partCentroids <- c()
  for (ending in enum) {
    centroidPath <- "C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\project\\MSR\\Relevance\\DistanceCalculation\\output\\centroids_"
    centroidPath <- paste0(centroidPath, ending, ".csv")
    allCentroids <- read.csv(centroidPath, header=FALSE)  
    
    monumentData <- allCentroids[allCentroids[,1] == monument,]
    enumCentroid <- mean(as.numeric(monumentData[,2:length(monumentData)]))
  
    partCentroids <- c(partCentroids, enumCentroid)
  }
  #normalized <- normalization(partCentroids)
  centroid <- mean(partCentroids)
  
  monumentCentroids <- rbind(monumentCentroids, c(monument, centroid))
}


# calculate point of each image and distance to centroid of respective location
imageVisScores <- c()
i <- 0
for (monument in names(poiList)) {
  imageScores <- c()
  idList <- noFaceDetected[noFaceDetected[,1]==monument,2]
  for (imgName in idList) {
    partPoints <- c()
    for (ending in enum) {
      filePath <- paste0("C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\div-2014\\devset\\descvis\\img\\", monument, " ", ending, ".csv")
      monumentFile <- read.csv(filePath, header=FALSE)
      imgData <- monumentFile[monumentFile[,1] == imgName,]
      
      imgEnumPoint <- mean(as.numeric(imgData[,2:length(imgData)]))
      
      partPoints <- c(partPoints, imgEnumPoint)
    }
    
    # normalized <- normalization(partPoints)
    imgPoint <- mean(partPoints)
    
    distance <- dist(rbind(imgPoint, monumentCentroids[monumentCentroids[,1] == monument,2]), method="euclidean")
    score <- 1 / distance
    
    imageData <- c(monument, imgName, score)
    imageScores <- rbind(imageScores, imageData)
  }
  
  normalizedScores <- normalization(as.numeric(imageScores[,3]))
  imageVisScores <- rbind(imageVisScores, cbind(imageScores[,1], imageScores[,2], normalizedScores))
  
  # for debugging reasons because it runs like forever
  i <- i + 1
  print(paste("done with", i, "-", monument))
}


# sort scores and save them in a data object
sortedScores <- c()
for (monument in names(poiList)) {
  unsortedScores <- imageVisScores[imageVisScores[,1] == monument,]
  sortedScores <- rbind(sortedScores, unsortedScores[order(-as.numeric(unsortedScores[,3])),])
} 

save(sortedScores, file = "C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\project\\MSR\\Relevance\\DistanceCalculation\\data\\sortedImgVisScores.RData")