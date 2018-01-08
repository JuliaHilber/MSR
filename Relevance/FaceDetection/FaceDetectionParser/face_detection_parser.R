data <- read.csv("/Users/Julia/Documents/Universität/MultimediaSearchAndRetrieval/Projekt/MSR/Relevance/FaceDetection/face_detection_result.txt", header=FALSE, sep="\t")

noFaceDetected <- data[data[,3]=="0",]

# [ add parsing of location filter ]


save(noFaceDetected, file="/Users/Julia/Documents/Universität/MultimediaSearchAndRetrieval/Projekt/MSR/Relevance/Preprocessing/preprocessed_result.RData")