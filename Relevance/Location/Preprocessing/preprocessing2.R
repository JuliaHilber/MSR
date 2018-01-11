location <- read.table("C:/Users/Alina/Documents/University/Multimedia Search & Retrieval/project/MSR/resultfiles/location_filter_result.txt")
tfidf <- read.table("C:/Users/Alina/Documents/University/Multimedia Search & Retrieval/project/MSR/resultfiles/similarityScores.txt")

# get only the half of the file
tfidf <- tfidf[1:(nrow(tfidf)/2), ]

result <- data.frame()

# calculate new similarity score with (tfidf+location)/2
for(i in 1:nrow(tfidf)) {
  id <- tfidf[i, 2]
  sim <- tfidf[i, 3] + location[which(location[, 2] == id), 3]/2
  result <- rbind(result, c(tfidf[i, 1], id, sim))
}

write.table(result, file="C:/Users/Alina/Documents/University/Multimedia Search & Retrieval/project/MSR/resultfiles/tfidf_location_SimilarityScores.txt", row.names = FALSE, col.names = FALSE)
