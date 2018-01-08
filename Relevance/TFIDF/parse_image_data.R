library(stringr)

imageDataPath <- '/Volumes/My Passport for Mac/div-2014/devset/desctxt/devset_textTermsPerImage.txt'
imageData <- readLines(con = imageDataPath)

imageDataList <- list()
for (line in imageData) {
  imageId <- substr(line, 0, regexpr(" ", line)-1)
  imageTerms <- substr(line, regexpr("\"", line), nchar(line))
  
  terms <- str_match_all(imageTerms, "\"([^ ]*)\"")[[1]][,2]
  tfidfs <- as.numeric(str_match_all(imageTerms, "\\d+\\s\\d+\\s(\\d+\\.\\d+)")[[1]][,2])
  
  imageDataList[[imageId]] <- data.frame(terms, tfidfs)
}

save(imageDataList, file = "/Users/Julia/Documents/Universität/MultimediaSearchAndRetrieval/Projekt/MSR/Relevance/TFIDF/data/imageList.RData")
