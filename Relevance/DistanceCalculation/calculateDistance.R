load("C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\project\\MSR\\Relevance\\TFIDF\\data\\poiList.RData")
load("C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\project\\MSR\\Relevance\\Preprocessing\\preprocessed_result.RData")

enum <- c("CM", "CM3x3", "CN", "CN3x3", "CSD", "GLRLM", "GLRLM3x3", "HOG", "LBP", "LBP3x3")

# help function to normalize the data from 0 to 1
normalization <- function(x){(x-min(x))/(max(x)-min(x))}

# calculate centroid per location
monumentCentroids <- c()
for (monument in names(poiList)) {
  partCenters <- c()
  for (ending in enum) {
    centroidPath <- "C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\project\\MSR\\Relevance\\DistanceCalculation\\output\\centroids_"
    centroidPath <- paste0(centroidPath, ending, ".csv")
    allCentroids <- read.csv(centroidPath, header=FALSE)    
    meanCentroid <- mean(as.numeric(allCentroids[allCentroids[,1] == monument,2:length(allCentroids)]))
    partCenters <- c(partCenters, meanCentroid)
  }
  
  no
  rmalized = normalization(partCenters)
  
  centroid <- c(monument, mean(normalized))
  monumentCentroids <- rbind(monumentCentroids, centroid)
}


# calculate point of each image and distance to centroid of respective location
imageDist <- c()
i <- 0
for (monument in names(poiList)) {
  imageData <- c()
  idList <- noFaceDetected[noFaceDetected[,1]==monument,2]
  for (imgName in idList) {
    imgPointInFile <- c()
    for (ending in enum) {
      filePath <- paste0("C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\div-2014\\devset\\descvis\\img\\", monument, " ", ending, ".csv")
      monumentFile <- read.csv(filePath, header=FALSE)
      
      meanImgPoint <- mean(as.numeric(monumentFile[monumentFile[,1] == imgName,2:length(monumentFile)]))
      imgPointInFile <- c(imgPointInFile, meanImgPoint)
    }
    
    normalized = normalization(imgPointInFile)
    
    imgPoint <- mean(imgPointInFile)
    distance <- dist(rbind(imgPoint, monumentCentroids[monumentCentroids[,1] == monument,2]), method="euclidean")
    
    imageData <- c(monument, imgName, distance)
    
    imageDist <- rbind(imageDist, imageData)
  }
  
  # for debugging reasons because it runs like forever
  i <- i + 1
  print(paste("done with", i, "-", monument))
}


# turn distances into scores and save them into a data object
scores <- 1 / as.numeric(imageDist[,3])
imageVisScores <- cbind(imageDist[,1], imageDist[,2], scores)

sortedScores <- c()
for (monument in names(poiList)) {
  unsortedScores <- imageVisScores[imageVisScores[,1] == monument,]
  
  sortedScores <- rbind(sortedScores, unsortedScores[order(-as.numeric(unsortedScores[,3])),])
} 

save(sortedScores, file = "C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\project\\MSR\\Relevance\\DistanceCalculation\\data\\sortedImgVisScores.RData")