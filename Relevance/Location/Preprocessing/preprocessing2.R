location <- read.table("/Users/Julia/Documents/Universität/MultimediaSearchAndRetrieval/Projekt/MSR/Relevance/Location/location_filter_result.txt", stringsAsFactors = FALSE)
tfidf <- read.table("/Users/Julia/Documents/Universität/MultimediaSearchAndRetrieval/Projekt/MSR/Relevance/TFIDF/similarityScores.txt", stringsAsFactors = FALSE)
data <- xmlParse("/Volumes/My Passport for Mac/div-2014/devset/devset_topics.xml")
xml_data <- xmlToList(data)

result <- NULL

# calculate new similarity score with (tfidf+location)/2
for(i in 1:nrow(tfidf)) {
  loc = 0
  for(j in 1:length(xml_data)) {
    title <- xml_data[j]$topic$title
    number <- xml_data[j]$topic$number
    if(tfidf[i, 1] == title) {
      loc = number
      break
    }
  }
  
  id <- tfidf[i, 2]
  sim <- tfidf[i, 3] + location[which(location[, 2] == id), 3]/2
  loc <- as.numeric(loc)
  result <- rbind(result, data.frame(A=loc, B=id, C=sim))
}

index <- which(duplicated(result[, 2]))
result <- result[-index, ]

write.table(result, file="/Users/Julia/Documents/Universität/MultimediaSearchAndRetrieval/Projekt/MSR/Relevance/Location/preprocessing/tfidf_location_SimilarityScores.txt", row.names = FALSE, col.names = FALSE)
