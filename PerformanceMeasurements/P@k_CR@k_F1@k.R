# load some files 
require(XML)
require(stringr)
data <- xmlParse("/Volumes/My Passport for Mac/div-2014/devset/devset_topics.xml")
xml_data <- xmlToList(data)


# load the file with relevance scores
result <- read.table("/Users/Julia/Documents/Universität/MultimediaSearchAndRetrieval/Projekt/Measurements/relevance.txt")
k <- 50

# some more variables
locations <- 30
allphotos <- k*locations
rar <- 0

# go over all locations
for(i in 1:length(xml_data)) {
  # get some parameter
  data <- xml_data[i]
  location <- data$topic$title
  number <- data$topic$number
  
  # load the relevant ground truth of that location
  gt <- read.table(paste0("/Volumes/My Passport for Mac/div-2014/devset/gt/rGT/", location, " rGT.txt"), sep=",")
 
  # get all photo id's of the relevance score file
  rel <- result[which(result[, 1] == location), ]
  rel <- rel[1:k, ]
  
  # if(the picture is relevant (get this from the ground truth)) then add 1 to the variable rar (relevant and retrieved)
  for(i in 1:k) {
    id <- rel[i, 2]
    if(gt[which(gt[, 1] == id), 2] == 1) {
      rar <- rar + 1
    }
  }
}

# calculate precision@k (P@k)
precision <- rar/allphotos

# calculate cluster recall @ k (CR@k)
recall <- 1

# calculate f1@k
f1 <- 2*(precision*recall)/(precision+recall)
  
