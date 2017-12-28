library(stringr)

poiPath <- 'C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\div-2014\\devset\\desctxt\\devset_textTermsPerPOI.wFolderNames.txt'
poiData <- readLines(con = poiPath)


poiList <- list()
for (line in poiData) {
  monument <- substr(line, 0, regexpr(" ", line)-1)
  monTerms <- substr(line, regexpr("\"", line), nchar(line))
  
  terms <- str_match_all(monTerms, "\"([^ ]*)\"")[[1]][,2]
  tfidfs <- as.numeric(str_match_all(monTerms, "\\d+\\s\\d+\\s(\\d+\\.\\d+)")[[1]][,2])
  
  poiList[[monument]] <- data.frame(terms, tfidfs)
}

save(poiList, file = "C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\project\\MSR\\Relevance\\TFIDF\\data\\poiList.RData")
