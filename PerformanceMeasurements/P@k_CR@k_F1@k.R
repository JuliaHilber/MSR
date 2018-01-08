# load some files 
library(XML)
library(stringr)
data <- xmlParse("/Volumes/My Passport for Mac/div-2014/devset/devset_topics.xml")
xml_data <- xmlToList(data)


# load the result file
result <- read.table("/Users/Julia/Documents/Universität/MultimediaSearchAndRetrieval/Projekt/MSR/Diversity/outputDevset/result.txt")
k <- 50

# some more variables
locations <- length(xml_data)
allphotos <- k

precisions <- c()
recalls <- c()
f1s <- c()

# go over all locations
for(i in 1:length(xml_data)) {
  rar <- 0
  
  # get some parameter
  data1 <- xml_data[i]
  location <- data1$topic$title
  number <- data1$topic$number
  
  # load the relevant ground truth of that location
  gt <- read.table(paste0("/Volumes/My Passport for Mac/div-2014/devset/gt/rGT/", location, " rGT.txt"), sep=",")
  gt1 <- read.table(paste0("/Volumes/My Passport for Mac/div-2014/devset/gt/dGT/", location, " dclusterGT.txt"), sep=",", quote="")
  gt2 <- read.table(paste0("/Volumes/My Passport for Mac/div-2014/devset/gt/dGT/", location, " dGT.txt"), sep=",")
    
  n <- nrow(gt1)
 
  # get all photo id's of the result file
  rel <- result[which(result[, 1] == number), ]
  rel <- rel[1:k, ]
  
  clusterList <- c()
  for(j in 1:k) {
    id <- rel[j, 3]
    
    # if(the picture is relevant (get this from the ground truth)) then add 1 to the variable rar (relevant and retrieved)
    if(gt[which(gt[, 1] == id), 2] == 1) {
      rar <- rar + 1
    }
    
    # if(the cluster with the picture is in the list) then do nothing, else add it to the list
    
    if(id %in% gt2[, 1]) {
      clusterno <- gt2[which(gt2[, 1] == id), 2]
      clusterList <- append(clusterList, clusterno)
    }
  }

  nc <- length(unique(clusterList))
  
  curPrec <- rar/allphotos
  curRec <- nc/n
  curF1 <- 2*(curPrec*curRec) / (curPrec+curRec)
  
  if (is.nan(curF1)) {
    curF1 = 0
  }
  
  precisions <- rbind(precisions, cbind(number, curPrec))
  recalls <- rbind(recalls, cbind(number, curRec))
  f1s <- rbind(f1s, cbind(number, curF1))
}

# calculate precision@k (P@k)
precision <- mean(as.numeric(precisions[,2]))

# calculate cluster recall @ k (CR@k)
recall <- mean(as.numeric(recalls[,2]))

# calculate F1@k
avgF1 <- mean(as.numeric(f1s[,2]))
f1 <- 2*(precision*recall)/(precision+recall)

# print the performance measurements
# we have to look how we want to calculate F1 in the end, since both methods are a legit possibility
print(paste("Precision:",precision))
print(paste("Recall:", recall))
print(paste("average F1:", avgF1))
print(paste("end-F1:", f1))
