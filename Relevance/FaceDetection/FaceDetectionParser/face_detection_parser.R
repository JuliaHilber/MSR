data <- read.csv("C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\project\\MSR\\Relevance\\FaceDetection\\face_detection_result.txt", header=FALSE, sep="\t")

noFaceDetected <- data[data[,3]=="0",]

# [ add parsing of location filter ]


save(noFaceDetected, file="C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\project\\MSR\\Relevance\\Preprocessing\\preprocessed_result.RData")