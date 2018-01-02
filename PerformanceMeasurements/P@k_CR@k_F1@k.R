# load some files 
library(XML)
library(stringr)
data <- xmlParse("C:/Users/Alina/Documents/University/Multimedia Search & Retrieval/div-2014/devset/devset_topics.xml")
xml_data <- xmlToList(data)


# load the result file
result <- read.table("C:/Users/Alina/Documents/University/Multimedia Search & Retrieval/project/MSR/Diversity/output/result.txt")
k <- 50

# some more variables
locations <- length(xml_data)
allphotos <- k*locations
# relevant and retrieved -> rar
rar <- 0
n <- 0
nc <- 0

# go over all locations
for(i in 1:length(xml_data)) {
  # get some parameter
  data1 <- xml_data[i]
  location <- data1$topic$title
  number <- data1$topic$number
  
  # load the relevant ground truth of that location
  gt <- read.table(paste0("C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\div-2014\\devset\\gt\\rGT\\", location, " rGT.txt"), sep=",")
  gt1 <- read.table(paste0("C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\div-2014\\devset\\gt\\dGT\\", location, " dclusterGT.txt"), sep=",", quote="")
  gt2 <- read.table(paste0("C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\div-2014\\devset\\gt\\dGT\\", location, " dGT.txt"), sep=",")
    
  n <- n + nrow(gt1)
 
  # get all photo id's of the result file
  rel <- result[which(result[, 1] == number), ]
  rel <- rel[1:k, ]
  
  list <- c(0)
  for(j in 1:k) {
    id <- rel[j, 3]
    # if(the picture is relevant (get this from the ground truth)) then add 1 to the variable rar (relevant and retrieved)
    if(gt[which(gt[, 1] == id), 2] == 1) {
      rar <- rar + 1
    }
    # if(the cluster with the picture is in the list) then do nothing, else add it to the list
    if(id %in% gt2[, 1]) {
      clusterno <- gt2[which(gt2[, 1] == id), 2]
      if(clusterno %in% list) {
        #do nothing
      } else {
        list <- append(list, clusterno)
      }
    }
  }
  nc <- nc + length(list)
}

# calculate precision@k (P@k)
precision <- rar/allphotos

# calculate cluster recall @ k (CR@k)
recall <- nc/n

# calculate F1@k
f1 <- 2*(precision*recall)/(precision+recall)

# print the performance measurements
print(precision)
print(recall)
print(f1)
