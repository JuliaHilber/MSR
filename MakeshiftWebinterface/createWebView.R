library(R2HTML)

# define paths
pathBaseWeb <- "C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\project\\MSR\\"
pathList <- paste0(pathBaseWeb, "Relevance\\TFIDF\\")
pathBaseImg <- "http://www.cp.jku.at/misc/div-2014/"
pathBaseMonuments <- "C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\div-2014\\"

# load data
filepath <- paste0(pathList,"similarityScores.txt")
file <- read.csv(filepath, header=FALSE, sep=" ")

path <- paste0(pathBaseImg, "testset\\img")
monuments <- list.dirs(path=paste0(pathBaseMonuments, "devset\\img"), full.names=FALSE, recursive=FALSE)

# set up web page
main <- HTMLInitFile(paste0(pathBaseWeb,"MakeshiftWebinterface"),"index", BackGroundColor="#DDDDDD", Title = "MMSR Project")
HTML(as.title("Multimedia Search and Retrieval"),file=main)


# add dropdown box for selecting monument
dropdownBox <- paste0(
  "<select monumentName=\"monument\" size=\"", nrow(monuments), "\"
  ONCHANGE=\"document.getElementById('monumentImages').src = this.options[this.selectedIndex].value\">")
for (monumentName in monuments) {
  dropdownBox <- paste0(dropdownBox, "<option value=\"monuments\\",monumentName,".html\">"
                        , monumentName, "</option>")
}
dropdownBox <- paste0(dropdownBox, "</select>")
HTML(dropdownBox,file=main)


# add iframe
settingsIFrame = "style=\"width: 100%;height: 73%;border: none;\"" 
HTML(paste0("<iframe src=\"monuments\\acropolis_athens.html\" name=\"monument\" id=\"monumentImages\"", settingsIFrame, ">)></iframe>"), file=main)

HTMLEndFile(file=main)



#filter for monument and show images
for (monumentName in monuments) {
  target <- HTMLInitFile(paste0(pathBaseWeb,"MakeshiftWebinterface/monuments"), monumentName,BackGroundColor="#DDDDDD")
  
  imagepath = paste0(pathBaseImg, "devset\\img\\")
  
  imageNames <- NULL
  
  monumentList <- file[file[,1]==monumentName,]
  HTML(paste("<br><br>", monumentName, "<br>", sep=""), file=target)
  
  HTML("<table>", file=target)
  for (i in seq(1,nrow(monumentList),3)) {
    path1 <- trimws(paste(imagepath, monumentName, "\\", monumentList[i,2], ".jpg", sep=""))
    HTML(paste('<tr><td><img src="', path1, '" alt="', monumentName, '" style="width:75%;">', sep=""), file=target)
    HTML(paste(monumentList[i,2], ".jpg</td>", sep=""), file=target)
    
    if (!is.na(monumentList[i+1,2])) {
      path2 <- trimws(paste(imagepath, monumentName, "\\", monumentList[i+1,2], ".jpg", sep=""))
      HTML(paste('<td><img src="', path2, '" alt="', monumentName, '" style="width:75%;">', sep=""), file=target)
      HTML(paste(monumentList[i+1,2], ".jpg</td>", sep=""), file=target)
    }
    
    if (!is.na(monumentList[i+2,2])) {
      path3 <- trimws(paste(imagepath, monumentName, "\\", monumentList[i+2,2], ".jpg", sep=""))
      HTML(paste('<td><img src="', path3, '" alt="', monumentName, '" style="width:75%;">', sep=""), file=target)
      HTML(paste(monumentList[i+2,2], ".jpg</td></tr>", sep=""), file=target)
    }
  }
  
  HTML("</table>", file=target)
  HTML(paste0("<br><br><br>"), file=target)
  
  HTMLEndFile(file=target)
}