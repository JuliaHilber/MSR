# preprocessing
library(XML)
library(stringr)

load("/Users/Julia/Documents/Universität/MultimediaSearchAndRetrieval/Projekt/MSR/Relevance/DistanceCalculation/data/sortedImgVisScores.RData")
load("/Users/Julia/Documents/Universität/MultimediaSearchAndRetrieval/Projekt/MSR/Relevance/TFIDF/data/poiList.RData")

data <- xmlParse("/Volumes/My Passport for Mac/div-2014/devset/devset_topics.xml")
xml_data <- xmlToList(data)

tfidf <- read.csv("/Users/Julia/Documents/Universität/MultimediaSearchAndRetrieval/Projekt/MSR/Relevance/Location/Preprocessing/tfidf_location_SimilarityScores.txt",
                  sep=" ")


# help function to normalize the data from 0 to 1
normalization <- function(x){(x-min(x))/(max(x)-min(x))}


# map location names to numbers
monumentMap <- c()
for(i in 1:length(xml_data)) {
  # map names to numbers
  data <- xml_data[i]
  location <- data$topic$title
  number <- data$topic$number
  
  monumentMap <- rbind(monumentMap, cbind(number, location))
}


normalized <- normalization(as.numeric(tfidf[,3]))
tfidfNormalized <- cbind(tfidf[,1], tfidf[,2], normalized)


relevancyScore <- c()
i <- 0
for (monument in names(poiList)) {
  monId <- monumentMap[monumentMap[,2] == monument, 1]
  imageIds <- tfidfNormalized[tfidfNormalized[,1] == monId,2]
  
  unsortedRelevancyScore <- c()
  for (img in imageIds) {
    tfidfScore <- tfidfNormalized[tfidfNormalized[,2] == img,3]
    visualScore <- as.numeric(sortedScores[sortedScores[,2] == img, 3])
    
    overallScore <- mean(c(tfidfScore, visualScore))
    
    unsortedRelevancyScore <- rbind(unsortedRelevancyScore, cbind(monId, img, overallScore))
  }
  
  # sort scores and write them to matrix
  relevancyScore <- rbind(relevancyScore, unsortedRelevancyScore[order(-as.numeric(unsortedRelevancyScore[,3])),])
  
  # for debugging reasons because it runs like forever
  i <- i + 1
  print(paste("done with", i, "-", monument))
}

write.table(relevancyScore,
            file="/Users/Julia/Documents/Universität/MultimediaSearchAndRetrieval/Projekt/MSR/Relevance/Postprocessing/data/relevancyScores.txt",
            append=FALSE,
            col.names=FALSE,
            row.names=FALSE,
            quote=FALSE,
            sep=" ")  

save(relevancyScore, file = "/Users/Julia/Documents/Universität/MultimediaSearchAndRetrieval/Projekt/MSR/Relevance/Postprocessing/data/relevancyScores.RData")