train <- read.table("R/UCI HAR Dataset/train/X_train.txt")
test <- read.table("R/UCI HAR Dataset/test/X_test.txt")
concat <- rbind(train,test)

nameTable <- read.table("R/UCI HAR Dataset/features.txt")
names(concat) <- nameTable[,2]
selected <- concat[,grep("(mean()|std())",names(concat))]

subject_train <- read.table("R/UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("R/UCI HAR Dataset/test/subject_test.txt")
y_train <- read.table("R/UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("R/UCI HAR Dataset/test/y_test.txt")

selected_add <- cbind(rbind(subject_train, subject_test), rbind(y_train, y_test),selected)
names(selected_add) <- c("subject", "y", names(selected))
tapply(selected_add, selected_add[,1], mean)
splitted <- split(selected_add, list(selected_add$subject,selected_add$y))
output <- sapply(splitted, colMeans)[3:81,]
write.table(output, "R/output.txt",row.name=FALSE)