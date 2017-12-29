# load some files 
require(XML)
require(stringr)
data <- xmlParse("/Volumes/My Passport for Mac/div-2014/devset/devset_topics.xml")
xml_data <- xmlToList(data)

# output file
sink("location_filter_result.txt")

# go over all locations
for(i in 1:length(xml_data)) {
  # get some parameter
  data <- xml_data[i]
  lat <- data$topic$latitude
  long <- data$topic$longitude
  location <- data$topic$title
  number <- data$topic$number
  
  # load the xml file of that location
  xml <- xmlParse(paste("/Volumes/My Passport for Mac/div-2014/devset/xml/", location, ".xml", sep=""))
  xml <- xmlToList(xml)
  
  # location filter
  count <- 0
  similarity <- c()
  for(photo in xml) {
    # get the longitude and latitude of that picture
    longp <- photo["longitude"]
    latp <- photo["latitude"]
    picture <- photo["id"]
    dist <- 0
    
    if((is.na(photo["longitude"]) || photo["longitude"] == 0) && (photo["latitude"] == 0 || is.na(photo["latitude"]))) {
      count <- count+1
      dist <- c(NA)
    } else {
      dist <- c(earth.dist(as.numeric(long), as.numeric(lat), as.numeric(photo["longitude"]), as.numeric(photo["latitude"])))
    }
    # calculate similarity
    sim <- 0
    if(!(is.na(dist)) && dist <= 109) {
      sim <- cos(dist/70)
    }
    similarity <- append(similarity, sim)
    
    # write in result file
    if(!is.na(picture)) {
      cat(location)
      cat("\t")
      cat(picture)
      cat("\t")
      cat(sim)
      cat("\n")
    }
  }
}

# close result file
sink()
  
# function for calculating the distance in kilometers between two points
earth.dist <- function (long1, lat1, long2, lat2)  {
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
