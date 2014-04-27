#Course project R script for Johns Hopkins' Coursera "Getting & Cleaning Data" course  
#April 2014
#This script downloads a zipped raw data set and outputs a cleaned, "tidy" data set in .txt format

#Load libraries
library(R.utils)  #For countLines() function
library(reshape2) #For melt() and dcast() functions

#create a data folder if necessary
if(!file.exists("./data")){dir.create("./data")}

#Download and unzip the data to the data folder
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/zipped_data.zip")
unzip("./data/zipped_data.zip", exdir = "./data")

#Determine the column classes of the large feature tables for faster reading
features.subset.train <- read.table("./data/UCI HAR Dataset/train/X_train.txt",header = FALSE, nrows = 3)
features.classes.train <- sapply(features.subset.train, class)
features.subset.test <- read.table("./data/UCI HAR Dataset/test/X_test.txt",header = FALSE, nrows = 3)
features.classes.test <- sapply(features.subset.test, class)

#Determine number of rows of the large feature tables to save memory usage
features.lines.train<-countLines("./data/UCI HAR Dataset/train/X_train.txt")
features.lines.test<-countLines("./data/UCI HAR Dataset/test/X_test.txt")

#Read the files into data frames
features.train <- read.table("./data/UCI HAR Dataset/train/X_train.txt",header = FALSE, comment.char = "", nrows=features.lines.train,colClasses=features.classes.train)
subject.train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt",header = FALSE, comment.char = "")
activity.train <- read.table("./data/UCI HAR Dataset/train/y_train.txt",header = FALSE, comment.char = "")
features.test <- read.table("./data/UCI HAR Dataset/test/X_test.txt",header = FALSE, comment.char = "", nrows=features.lines.test,colClasses=features.classes.test)
subject.test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt",header = FALSE, comment.char = "")
activity.test <- read.table("./data/UCI HAR Dataset/test/y_test.txt",header = FALSE, comment.char = "")
feature.names <- read.table("./data/UCI HAR Dataset/features.txt",header = FALSE, comment.char = "")
activity.labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt",header = FALSE, comment.char = "", as.is=TRUE)

#Give "meaningful" labels to the columns of the feature data frames using the features file
names(features.train) <- feature.names[,2]
names(features.test) <- feature.names[,2]

#Give the obvious "meaningful" labels to the columns of the subject and activity data frames
names(subject.train) <- "subject"
names(activity.train) <- "activity"
names(subject.test) <- "subject"
names(activity.test) <- "activity"

#Bind together the subject, activity and feature data frames to make the test and training data sets
raw.dataset.train <- cbind(subject.train,activity.train,features.train)
raw.dataset.test <- cbind(subject.test,activity.test,features.test)

#Bind together the test and training data frames to make one large data set
raw.dataset <- rbind(raw.dataset.train, raw.dataset.test)

#Retain only the feature columns pertaining to standard deviation and mean
slim.raw.dataset<-raw.dataset[,c(1, 2, grep("(.*)(-std|-mean\\(\\))",names(raw.dataset)))]

#Use the descriptive activity labels from the activity_labels file to name the activities 
# use the data frame obtained to replace the activity numbers with the corresponding descriptive label
for (i in seq(along=slim.raw.dataset$activity)){
  slim.raw.dataset$activity[i]<-subset(activity.labels, activity.labels$V1==slim.raw.dataset$activity[i])[[2]]}
# convert the relevant column to factor
slim.raw.dataset$activity <- as.factor(slim.raw.dataset$activity)

#Create a tidy data set with the average of each variable for each activity and each subject
# create a vector of names of relevant features
feature.list <- names(raw.dataset)[grep("(.*)(-std|-mean\\(\\))",names(raw.dataset))]
# melt the dataset
datasetMelt <- melt(slim.raw.dataset, id=c("subject", "activity"), measure.vars=feature.list)
# recast the melted dsataset as required
tidy.dataset <- dcast(datasetMelt, subject + activity ~ variable, mean)

#Write the tidy data set to a .txt file 
write.table(tidy.dataset, file = "tidy_dataset.txt")