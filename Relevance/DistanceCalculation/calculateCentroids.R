# old code, very messy!!


files <- list.files(path="C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\div-2014\\devset\\descvis\\imgwiki", 
                    pattern="*CM.csv", full.names=T, recursive=FALSE)

masterfile <- NULL
for (file in files) {
    t <- read.csv(file, header=FALSE)

  if (0 != length(grep("\\(*\\)", t[,2]))) {
    index <- grep("\\(*\\)", t[,2])
    
    t[index,1] <- paste0(t[index,1], ",", t[index,2])
    
    for (i in seq(3, ncol(t))-1) {
      t[index,i] <- t[index,i+1]
    }
    lastCol <- ncol(t)-1
    t <- t[1:lastCol]
  }
  
  if (is.character(t[,2])) {
    t[,2] <- as.numeric(t[,2])
  }
  
  normalized <- t(apply(t[-1], 1, function(x) {
    (x-min(x)) / (max(x)-min(x))
  }))
  
  # calculate centroids
  centroid <- colMeans(normalized)
  name <- substr(t[1,1],1,regexpr('\\(', t[1,1])-1)
  masterfile <- rbind(masterfile, c(name, centroid))
  
}

write.table(masterfile, 
"C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\project\\MSR\\Relevance\\DistanceCalculation\\output\\centroids_CM.csv",
            sep=",", quote=FALSE, row.names=F, col.names=F)

# ------
rm(list=ls())

files <- list.files(path="C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\div-2014\\devset\\descvis\\imgwiki", 
                    pattern="*GLRLM.csv", full.names=T, recursive=FALSE)

masterfile <- NULL
for (file in files) {
  t <- read.csv(file, header=FALSE)
  
  if (0 != length(grep("\\(*\\)", t[,2]))) {
    index <- grep("\\(*\\)", t[,2])
    
    t[index,1] <- paste0(t[index,1], ",", t[index,2])
    
    for (i in seq(3, ncol(t))-1) {
      t[index,i] <- t[index,i+1]
    }
    lastCol <- ncol(t)-1
    t <- t[1:lastCol]
  }
  
  if (is.character(t[,2])) {
    t[,2] <- as.numeric(t[,2])
  }
  
  normalized <- t(apply(t[-1], 1, function(x)(x-min(x))/(max(x)-min(x))))
  
  # calculate centroids
  centroid <- colMeans(normalized)
  name <- substr(t[1,1],1,regexpr('\\(', t[1,1])-1)
  masterfile <- rbind(masterfile, c(name, centroid))
}

write.table(masterfile, 
            "C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\project\\MSR\\Relevance\\DistanceCalculation\\output\\centroids_GLRLM.csv",
            sep=",", quote=FALSE, row.names=F, col.names=F)


# ------
rm(list=ls())

files <- list.files(path="C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\div-2014\\devset\\descvis\\imgwiki", 
                    pattern="*CM3x3.csv", full.names=T, recursive=FALSE)

masterfile <- NULL
for (file in files) {
  t <- read.csv(file, header=FALSE)
  
  if (0 != length(grep("\\(*\\)", t[,2]))) {
    index <- grep("\\(*\\)", t[,2])
    
    t[index,1] <- paste0(t[index,1], ",", t[index,2])
    
    for (i in seq(3, ncol(t))-1) {
      t[index,i] <- t[index,i+1]
    }
    lastCol <- ncol(t)-1
    t <- t[1:lastCol]
  }
  
  if (is.character(t[,2])) {
    t[,2] <- as.numeric(t[,2])
  }
  
  normalized <- t(apply(t[-1], 1, function(x)(x-min(x))/(max(x)-min(x))))
  
  # calculate centroids
  centroid <- colMeans(normalized)
  name <- substr(t[1,1],1,regexpr('\\(', t[1,1])-1)
  masterfile <- rbind(masterfile, c(name, centroid))
}

write.table(masterfile, 
            "C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\project\\MSR\\Relevance\\DistanceCalculation\\output\\centroids_CM3x3.csv",
            sep=",", quote=FALSE, row.names=F, col.names=F)


# ------
rm(list=ls())

files <- list.files(path="C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\div-2014\\devset\\descvis\\imgwiki", 
                    pattern="*CN.csv", full.names=T, recursive=FALSE)

masterfile <- NULL
for (file in files) {
  t <- read.csv(file, header=FALSE)
  
  if (0 != length(grep("\\(*\\)", t[,2]))) {
    index <- grep("\\(*\\)", t[,2])
    
    t[index,1] <- paste0(t[index,1], ",", t[index,2])
    
    for (i in seq(3, ncol(t))-1) {
      t[index,i] <- t[index,i+1]
    }
    lastCol <- ncol(t)-1
    t <- t[1:lastCol]
  }
  
  if (is.character(t[,2])) {
    t[,2] <- as.numeric(t[,2])
  }
  
  normalized <- t(apply(t[-1], 1, function(x)(x-min(x))/(max(x)-min(x))))
  
  # calculate centroids
  centroid <- colMeans(normalized)
  name <- substr(t[1,1],1,regexpr('\\(', t[1,1])-1)
  masterfile <- rbind(masterfile, c(name, centroid))
}

write.table(masterfile, 
            "C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\project\\MSR\\Relevance\\DistanceCalculation\\output\\centroids_CN.csv",
            sep=",", quote=FALSE, row.names=F, col.names=F)

# ------
rm(list=ls())

files <- list.files(path="C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\div-2014\\devset\\descvis\\imgwiki", 
                    pattern="*CN3x3.csv", full.names=T, recursive=FALSE)

masterfile <- NULL
for (file in files) {
  t <- read.csv(file, header=FALSE)
  
  if (0 != length(grep("\\(*\\)", t[,2]))) {
    index <- grep("\\(*\\)", t[,2])
    
    t[index,1] <- paste0(t[index,1], ",", t[index,2])
    
    for (i in seq(3, ncol(t))-1) {
      t[index,i] <- t[index,i+1]
    }
    lastCol <- ncol(t)-1
    t <- t[1:lastCol]
  }
  
  if (is.character(t[,2])) {
    t[,2] <- as.numeric(t[,2])
  }
  
  normalized <- t(apply(t[-1], 1, function(x)(x-min(x))/(max(x)-min(x))))
  
  # calculate centroids
  centroid <- colMeans(normalized)
  name <- substr(t[1,1],1,regexpr('\\(', t[1,1])-1)
  masterfile <- rbind(masterfile, c(name, centroid))
}

write.table(masterfile, 
            "C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\project\\MSR\\Relevance\\DistanceCalculation\\output\\centroids_CN3x3.csv",
            sep=",", quote=FALSE, row.names=F, col.names=F)


# ------
rm(list=ls())

files <- list.files(path="C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\div-2014\\devset\\descvis\\imgwiki", 
                    pattern="*GLRLM3x3.csv", full.names=T, recursive=FALSE)

masterfile <- NULL
for (file in files) {
  t <- read.csv(file, header=FALSE)
  
  if (0 != length(grep("\\(*\\)", t[,2]))) {
    index <- grep("\\(*\\)", t[,2])
    
    t[index,1] <- paste0(t[index,1], ",", t[index,2])
    
    for (i in seq(3, ncol(t))-1) {
      t[index,i] <- t[index,i+1]
    }
    lastCol <- ncol(t)-1
    t <- t[1:lastCol]
  }
  
  if (is.character(t[,2])) {
    t[,2] <- as.numeric(t[,2])
  }
  
  normalized <- t(apply(t[-1], 1, function(x)(x-min(x))/(max(x)-min(x))))
  
  # calculate centroids
  centroid <- colMeans(normalized)
  name <- substr(t[1,1],1,regexpr('\\(', t[1,1])-1)
  masterfile <- rbind(masterfile, c(name, centroid))
}

write.table(masterfile, 
            "C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\project\\MSR\\Relevance\\DistanceCalculation\\output\\centroids_GLRLM3x3.csv",
            sep=",", quote=FALSE, row.names=F, col.names=F)


# ------
rm(list=ls())

files <- list.files(path="C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\div-2014\\devset\\descvis\\imgwiki", 
                    pattern="*LBP.csv", full.names=T, recursive=FALSE)

masterfile <- NULL
for (file in files) {
  t <- read.csv(file, header=FALSE)
  
  if (0 != length(grep("\\(*\\)", t[,2]))) {
    index <- grep("\\(*\\)", t[,2])
    
    t[index,1] <- paste0(t[index,1], ",", t[index,2])
    
    for (i in seq(3, ncol(t))-1) {
      t[index,i] <- t[index,i+1]
    }
    lastCol <- ncol(t)-1
    t <- t[1:lastCol]
  }
  
  if (is.character(t[,2])) {
    t[,2] <- as.numeric(t[,2])
  }
  
  normalized <- t(apply(t[-1], 1, function(x)(x-min(x))/(max(x)-min(x))))
  
  # calculate centroids
  centroid <- colMeans(normalized)
  name <- substr(t[1,1],1,regexpr('\\(', t[1,1])-1)
  masterfile <- rbind(masterfile, c(name, centroid))
}

write.table(masterfile, 
            "C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\project\\MSR\\Relevance\\DistanceCalculation\\output\\centroids_LBP.csv",
            sep=",", quote=FALSE, row.names=F, col.names=F)


# ------
rm(list=ls())

files <- list.files(path="C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\div-2014\\devset\\descvis\\imgwiki", 
                    pattern="*LBP3x3.csv", full.names=T, recursive=FALSE)

masterfile <- NULL
for (file in files) {
  t <- read.csv(file, header=FALSE)
  
  if (0 != length(grep("\\(*\\)", t[,2]))) {
    index <- grep("\\(*\\)", t[,2])
    
    t[index,1] <- paste0(t[index,1], ",", t[index,2])
    
    for (i in seq(3, ncol(t))-1) {
      t[index,i] <- t[index,i+1]
    }
    lastCol <- ncol(t)-1
    t <- t[1:lastCol]
  }
  
  if (is.character(t[,2])) {
    t[,2] <- as.numeric(t[,2])
  }
  
  normalized <- t(apply(t[-1], 1, function(x)(x-min(x))/(max(x)-min(x))))
  
  # calculate centroids
  centroid <- colMeans(normalized)
  name <- substr(t[1,1],1,regexpr('\\(', t[1,1])-1)
  masterfile <- rbind(masterfile, c(name, centroid))
}

write.table(masterfile, 
            "C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\project\\MSR\\Relevance\\DistanceCalculation\\output\\centroids_LBP3x3.csv",
            sep=",", quote=FALSE, row.names=F, col.names=F)


# ------
rm(list=ls())

files <- list.files(path="C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\div-2014\\devset\\descvis\\imgwiki", 
                    pattern="*HOG.csv", full.names=T, recursive=FALSE)

masterfile <- NULL
for (file in files) {
  t <- read.csv(file, header=FALSE)
  
  if (0 != length(grep("\\(*\\)", t[,2]))) {
    index <- grep("\\(*\\)", t[,2])
    
    t[index,1] <- paste0(t[index,1], ",", t[index,2])
    
    for (i in seq(3, ncol(t))-1) {
      t[index,i] <- t[index,i+1]
    }
    lastCol <- ncol(t)-1
    t <- t[1:lastCol]
  }
  
  if (is.character(t[,2])) {
    t[,2] <- as.numeric(t[,2])
  }
  
  normalized <- t(apply(t[-1], 1, function(x)(x-min(x))/(max(x)-min(x))))
  
  # calculate centroids
  centroid <- colMeans(normalized)
  name <- substr(t[1,1],1,regexpr('\\(', t[1,1])-1)
  masterfile <- rbind(masterfile, c(name, centroid))
}

write.table(masterfile, 
            "C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\project\\MSR\\Relevance\\DistanceCalculation\\output\\centroids_HOG.csv",
            sep=",", quote=FALSE, row.names=F, col.names=F)

# ------
rm(list=ls())

files <- list.files(path="C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\div-2014\\devset\\descvis\\imgwiki", 
                    pattern="*CSD.csv", full.names=T, recursive=FALSE)

masterfile <- NULL
for (file in files) {
  t <- read.csv(file, header=FALSE)
  
  if (0 != length(grep("\\(*\\)", t[,2]))) {
    index <- grep("\\(*\\)", t[,2])
    
    t[index,1] <- paste0(t[index,1], ",", t[index,2])
    
    for (i in seq(3, ncol(t))-1) {
      t[index,i] <- t[index,i+1]
    }
    lastCol <- ncol(t)-1
    t <- t[1:lastCol]
  }
  
  if (is.character(t[,2])) {
    t[,2] <- as.numeric(t[,2])
  }
  
  normalized <- t(apply(t[-1], 1, function(x)(x-min(x))/(max(x)-min(x))))
  
  # calculate centroids
  centroid <- colMeans(normalized)
  name <- substr(t[1,1],1,regexpr('\\(', t[1,1])-1)
  masterfile <- rbind(masterfile, c(name, centroid))
}

write.table(masterfile, 
            "C:\\Users\\Alina\\Documents\\University\\Multimedia Search & Retrieval\\project\\MSR\\Relevance\\DistanceCalculation\\output\\centroids_CSD.csv",
            sep=",", quote=FALSE, row.names=F, col.names=F)