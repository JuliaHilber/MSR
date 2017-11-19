# load some files 
require(XML)
require(stringr)
data <- xmlParse("/Volumes/My Passport for Mac/div-2014/devset/devset_topics.xml")
xml_data <- xmlToList(data)
# output file
sink("location.txt")

for(i in 1:length(xml_data)) {
  data <- xml_data[i]
  lat <- data$topic$latitude
  long <- data$topic$longitude
  
  location <- data$topic$title
  number <- data$topic$number

  xml <- xmlParse(paste("/Volumes/My Passport for Mac/div-2014/devset/xml/", location, ".xml", sep=""))
  xml <- xmlToList(xml)

  # location filter
  count <- 0
  a <- c(0)
  for(photo in xml) {
    longp <- photo["longitude"]
    latp <- photo["latitude"]
    if((is.na(photo["longitude"]) || photo["longitude"] == 0) && (photo["latitude"] == 0 || is.na(photo["latitude"]))) {
      count <- count+1
      a <- append(a, c(NA))
    } else {
      a <- append(a, c(earth.dist(as.numeric(long), as.numeric(lat), as.numeric(photo["longitude"]), as.numeric(photo["latitude"]))))
    }
  }
  a <- a[2: (length(a)-1)]
  similarity = vector(mode="numeric", length=(xmlSize(xml)-1))
  for(j in which(a < 0.5)) {
    similarity[j] = 1
  }
  
  # tag/term/title filter
  words <- c("pizza","pasta", "spaghetti", "penne", "cat", "dog", "person", "people", "group", "restoration", "way to", "street to")
  a <- c(0)
  img <- c(0)
  for(photo in xml) {
    a <- append(a, length(which(str_extract(paste(photo["tags"], photo["title"], sep=""), words) != "NA")))
    img <- append(img, photo["id"])
  }
  a <- a[2: (length(a)-1)]
  img <- img[2: (length(img)-1)]
  b <- ifelse(a == 0, 1, 1-1/a)
  similarity <- (similarity + b) / 2
  
  table <- data.frame(img, similarity)
  
  # load CSD visual table for k-means
  visual <- read.csv(paste("/Volumes/My Passport for Mac/div-2014/devset/descvis/img/", location, " CSD.csv", sep=""), header = FALSE)
  
  howMany <- which(similarity > 0.5)
  treshold <- 0.5
  if(length(howMany) > 50) {
    treshold <- 1
  }
  
  ## use only pictures with similarity >= treshold
  #indices in table which have similarity < treshold
  index <- which(table[, 2] < treshold)
  #remove images from visual with the table[index, 1]
  for(j in levels(table[1, 1])[index]) {
    if(!is.na(j)) {
     ind <- which(as.character(visual[, 1]) == j)
     visual <- visual[-ind, ]
    }
  }
  
  table <- table[-index, ]
  
  # k-means
  kmeans <- kmeans(visual, 50)
  
  # take the relevantest photo per cluster, begin with the greatest cluster
  x <- data.frame(1:50, kmeans$size)
  x <- x[order(x[, 2], decreasing = TRUE), ]
  #x[i, ] = cluster number
  #x[, i] = number of pictures in the cluster
  for(j in 1:50) {
    clusterno <- x[j, 1]
    indicesForThisCluster <- which(kmeans$cluster == clusterno)
    mostImportantPhoto <- c(0, 0)
    for(index in indicesForThisCluster) {
      if(mostImportantPhoto[2] <= table[index, 2] && !is.na(table[index, 2])) {
        mostImportantPhoto <- c(levels(table[1, 1])[index], table[index, 2])
      }
    }
    # write in result file
    cat(number)
    cat("\t")
    cat("0")
    cat("\t")
    cat(mostImportantPhoto[1])
    cat("\t")
    cat(j)
    cat("\t")
    cat(0)
    cat("\t")
    cat(mostImportantPhoto[2])
    cat("\n")
  }
}
# close result file
sink()


# function for calculating the distance in kilometers between two points
earth.dist <- function (long1, lat1, long2, lat2)
{
  rad <- pi/180
  a1 <- lat1 * rad
  a2 <- long1 * rad
  b1 <- lat2 * rad
  b2 <- long2 * rad
  dlon <- b2 - a2
  dlat <- b1 - a1
  a <- (sin(dlat/2))^2 + cos(a1) * cos(b1) * (sin(dlon/2))^2
  c <- 2 * atan2(sqrt(a), sqrt(1 - a))
  R <- 6378.145
  d <- R * c
  return(d)
}



