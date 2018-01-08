postprocessing <- read.table("/Users/Julia/Documents/Universität/MultimediaSearchAndRetrieval/Projekt/MSR/Relevance/Postprocessing/data/relevancyScores.txt")
views <- read.table("/Users/Julia/Documents/Universität/MultimediaSearchAndRetrieval/Projekt/MSR/Relevance/ViewFilter/views.txt")

result <- data.frame()

# calculate new similarity score with 0.5*postprocessing + 0.5*views
for(i in 1:nrow(postprocessing)) {
  id <- postprocessing[i, 2]
  sim <- 0.75*postprocessing[i, 3] + 0.25*views[which(views[, 2] == id), 3]
  result <- rbind(result, c(postprocessing[i, 1], id, sim))
}

write.table(result, file="/Users/Julia/Documents/Universität/MultimediaSearchAndRetrieval/Projekt/MSR/Relevance/ViewFilter/Processing/SimilarityScores.txt", row.names = FALSE, col.names = FALSE)
