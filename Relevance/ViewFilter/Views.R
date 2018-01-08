require(XML)
require(stringr)
data <- xmlParse("/Volumes/My Passport for Mac/div-2014/devset/devset_topics.xml")
xml_data <- xmlToList(data)

nbComments <- c()
views <- c()
ids <- c()

v <- data.frame("location"=character(), "id"=character(), "sim"=numeric(), stringsAsFactors = FALSE)

# go over all locations
for(i in 1:length(xml_data)) {
  # get some parameter
  data <- xml_data[i]
  location <- data$topic$title
  number <- data$topic$number
  
  # load the xml file of that location
  xml <- xmlParse(paste("/Volumes/My Passport for Mac/div-2014/devset/xml/", location, ".xml", sep=""))
  xml <- xmlToList(xml)
  
  for(photo in xml) {
    nbComments <- append(nbComments, photo["nbComments"])
    views <- append(views, photo["views"])
    ids <- append(ids, photo["id"])
    id <- photo["id"]
    sim <-1
    if((!is.na(photo["views"])) && as.numeric(photo["views"]) <= 300) {
      sim <- 1/300*as.numeric(photo["views"]) 
    }
    if(!is.na(photo["views"])) {
      v <- rbind(v, data.frame("location"=location, "id"=as.character(id), "sim"=sim))
    }
  }
}

write.table(v, file="/Users/Julia/Documents/Universität/MultimediaSearchAndRetrieval/Projekt/MSR/Relevance/ViewFilter/views.txt", row.names = FALSE, col.names = FALSE)

#views <- as.numeric(as.vector(views))
#boxplot(views, ylim=c(0, 500))
# max: 87023, min: 0

#nbComments <- as.numeric(as.vector(nbComments))
#boxplot(nbComments)

