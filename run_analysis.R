## Merge the training and test data sets to create one data set

trainx <- read.table("train/X_train.txt")
testx <- read.table("test/X_test.txt")
data <- rbind(trainx, testx)

## Extract only the measurements on the mean and std for each measurement
features <- read.table("features.txt")
featuresmean<- features[grepl("mean()", features[,2]),]
featuresstd<- features[grepl("std()", features[,2]),]
features <- rbind(featuresmean, featuresstd)
features <- features[order(features[,1]),]

data <- data[,features[,1]]

## Name the columns of data
colnames(data) <- features[,2]

## Add subject data
trainsubject <- read.table("train/subject_train.txt")
testsubject <- read.table("test/subject_test.txt")
subject <- rbind(trainsubject, testsubject)
names(subject) <- "subject"
data <- cbind(data, subject)

## Merge the label tables
trainy <- read.table("train/y_train.txt")
testy <- read.table("test/y_test.txt")
labels <- rbind(trainy, testy)

## Replace number values with activity names
labels <- replace(labels, labels == 1, "WALKING")
labels <- replace(labels, labels == 2, "WALKING UPSTAIRS")
labels <- replace(labels, labels == 3, "WALKING DOWNSTAIRS")
labels <- replace(labels, labels == 4, "SITTING")
labels <- replace(labels, labels == 5, "STANDING")
labels <- replace(labels, labels == 6, "LAYING")
names(labels) <- "activity"

## Bind activity names to last column of data
data <- cbind(data, labels)

## Label the data set with descriptive variable names
names(data) <- gsub("-", " ", names(data))
names(data) <- gsub("\\()", "", names(data))

## Create a second, independent tidy data set with
## the average of each variable for each activity and each subject
tidy <- aggregate(data, by = list(activity = data$activity, subject = data$subject), mean)
tidy[,83] = NULL
tidy [,82] = NULL
write.table(tidy, file = "tidy.txt", row.names = FALSE)