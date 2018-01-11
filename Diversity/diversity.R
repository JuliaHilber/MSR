# load some files 
require(XML)
require(stringr)
data <- xmlParse("C:/Users/Alina/Documents/University/Multimedia Search & Retrieval/div-2014/testset/testset_topics.xml")
#data <- xmlParse("/Volumes/My Passport for Mac/div-2014/devset/devset_topics.xml")
xml_data <- xmlToList(data)


# load relevance score file
#relevance <- read.table("C:/Users/Alina/Documents/University/Multimedia Search & Retrieval/project/MSR/Relevance/Location/Preprocessing/tfidf_location_SimilarityScores.txt")
#relevance <- read.table("C:/Users/Alina/Documents/University/Multimedia Search & Retrieval/project/MSR/Relevance/Postprocessing/data/relevancyScores.txt")
#relevance <- read.table("/Users/Julia/Documents/Universität/MultimediaSearchAndRetrieval/Projekt/MSR/Relevance/ViewFilter/Processing/SimilarityScores.txt")
relevance <- read.table("C:/Users/Alina/Documents/University/Multimedia Search & Retrieval/project/MSR/resultfiles/relevancyScores.txt")
relevance[, 2] <- as.character(relevance[, 2])

#c <- c()

# go over all locations
imgPath <- "C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\div-2014\\testset\\descvis\\img\\"
#imgPath <- "/Volumes/My Passport for Mac/div-2014/devset/descvis/img/"
lines <- c()

print(paste("Start:", Sys.time()))

for(i in 1:length(xml_data)) {
  # get some parameter
  data1 <- xml_data[i]
  location <- data1$topic$title
  number <- data1$topic$number
  
  cm <- read.csv(paste(imgPath, location, " CM.csv", sep=""), header = FALSE)
  cm3 <- read.csv(paste(imgPath, location, " CM3x3.csv", sep=""), header = FALSE)
  cn <- read.csv(paste(imgPath, location, " CN.csv", sep=""), header = FALSE)
  cn3 <- read.csv(paste(imgPath, location, " CN3x3.csv", sep=""), header = FALSE)
  csd <- read.csv(paste(imgPath, location, " CSD.csv", sep=""), header = FALSE)
  glrlm <- read.csv(paste(imgPath, location, " GLRLM.csv", sep=""), header = FALSE)
  glrlm3 <- read.csv(paste(imgPath, location, " GLRLM3x3.csv", sep=""), header = FALSE)
  hog <- read.csv(paste(imgPath, location, " HOG.csv", sep=""), header = FALSE)
  lbp <- read.csv(paste(imgPath, location, " LBP.csv", sep=""), header = FALSE)
  lbp3 <- read.csv(paste(imgPath, location, " LBP3x3.csv", sep=""), header = FALSE)
  cm[, 1] <- as.character(cm[, 1])
  cm3[, 1] <- as.character(cm3[, 1])
  cn[, 1] <- as.character(cn[, 1])
  cn3[, 1] <- as.character(cn3[, 1])
  csd[, 1] <- as.character(csd[, 1])
  glrlm[, 1] <- as.character(glrlm[, 1])
  glrlm3[, 1] <- as.character(glrlm3[, 1])
  hog[, 1] <- as.character(hog[, 1])
  lbp[, 1] <- as.character(lbp[, 1])
  lbp3[, 1] <- as.character(lbp3[, 1])
  
  ####TODO, add these ones you need
  visual <- merge(cm, cm3, by="V1")
  visual <- merge(visual, cn, by="V1")
  #visual <- merge(cm, cn, by="V1")
  #visual <- merge(cm3, cn3, by="V1")
  visual <- merge(visual, cn3, by="V1")
  visual <- merge(visual, csd, by="V1")
  visual <- merge(visual, glrlm, by="V1")
  visual <- merge(visual, glrlm3, by="V1")
  visual <- merge(visual, hog, by="V1")
  visual <- merge(visual, lbp, by="V1")
  visual <- merge(visual, lbp3, by="V1")
  
  # include tf-idf
  #rela <- relevance[, c(2, 3)]
  #colnames(rela) <- c("V1", "V2")
  #visual <- merge(visual, rela, by="V1")
  
  # delete all rows which pic id in visual is not in relevance
  visual <- visual[visual[, 1] %in% relevance[, 2], ]
  
  # k-means
  k <- 50
  kmeans <- kmeans(visual, k)
  
  # take the relevantest photo per cluster, begin with the greatest cluster
  x <- data.frame(1:k, kmeans$size)
  x <- x[order(x[, 2], decreasing = TRUE), ]
  #x[i, ] = cluster number
  #x[, i] = number of pictures in the cluster
  list <- c()
  y <- 0
  j <- 0
  while(j <= 49) {
    y <- y %% k + 1
    clusterno <- x[(y), 1]
    picIDForThisCluster <- visual[which(kmeans$cluster == clusterno), 1]
    mostImportantPhoto <- c(0, 0)
    for(index in picIDForThisCluster) {
      if(mostImportantPhoto[2] <= relevance[which(relevance[, 2] == index), 3] && !is.na(relevance[which(relevance[, 2] == index), 3]) && !(index %in% list)) {
        mostImportantPhoto <- c(relevance[which(relevance[, 2] == index), 2], relevance[which(relevance[, 2] == index), 3])
      }
    }
    if(!(mostImportantPhoto[1] %in% list) && mostImportantPhoto[1] != 0) {
      list <- append(list, mostImportantPhoto[1])
      # write in result  file
      lines <- rbind(lines,
                     cbind(number, "0", mostImportantPhoto[1], j, "0", mostImportantPhoto[2]))
      
      j <- j + 1
    }
  }
}

print(paste("End:", Sys.time()))
# write to result file
write.table(lines,
            file="C:/Users/Alina/Documents/University/Multimedia Search & Retrieval/project/MSR/Diversity/outputTestset/result.txt",
            append=FALSE,
            col.names=FALSE,
            row.names=FALSE,
            quote=FALSE,
            sep="\t") 

print(paste("Written to file:", Sys.time()))
