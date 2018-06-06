##############################################################################
#step 0: Downloading the file
##############################################################################

fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./Dataset.zip")

#Unzip the dataset
unzip(zipfile = "./Dataset.zip", exdir=".")

##############################################################################
#Step 1: Loading and merging the data
##############################################################################
install.packages("data.table")
library(data.table)

#Reading the train dataset

subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
xTrain <- read.table("./UCI HAR Dataset/train/X_train.txt",header = FALSE)
yTrain <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)

#Reading the test dataset

subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
xTest <- read.table("./UCI HAR Dataset/test/X_test.txt",header = FALSE)
yTest <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)

#Reading the feature vector
features <- read.table("./UCI HAR Dataset/features.txt",header = FALSE)

# Reading activity labels:
activityLabels <- read.table('./UCI HAR Dataset/activity_labels.txt',header = FALSE)

#Assigning column names
colnames(xTrain) <- features[,2]
colnames(xTest) <- features[,2]

colnames(yTrain) <- "activityId"
colnames(yTest) <- "activityId"

colnames(subjectTrain) <- "subjectId"
colnames(subjectTest) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

#Organizing and combining raw data sets into single one.

subjectDataset <- rbind(subjectTrain,subjectTest)
xDataset <- rbind(xTrain,xTest)
yDataset <- rbind(yTrain,yTest)

Dataset <- cbind(xDataset,subjectDataset,yDataset)


##############################################################################
#Step 2: Extract only the measurements on the mean and 
# standard deviation for each measurement.
##############################################################################

# determine columns of data set to keep based on column name
columnsToKeep <- grepl("subject|activity|mean|std", colnames(Dataset))
Dataset <- Dataset[,columnsToKeep]


##############################################################################
# Step 3 - Use descriptive activity names to name the activities in the data
##############################################################################

Dataset$activityId <- factor(Dataset$activityId,
                             levels = activityLabels[, 1], labels = activityLabels[, 2])


##############################################################################
# Step 4 - Appropriately label the data set with descriptive variable names
##############################################################################

#get columns names
DatasetCols <- colnames(Dataset)

DatasetCols <- gsub("[\\(\\)-]","",DatasetCols)

# expand abbreviations and clean up names
DatasetCols <- gsub("^f", "frequencyDomain.", DatasetCols)
DatasetCols <- gsub("^t", "timeDomain.", DatasetCols)
DatasetCols <- gsub("Acc", "Accelerometer.", DatasetCols)
DatasetCols <- gsub("GyroJerk", "AngularAcceleration.", DatasetCols)
DatasetCols <- gsub("Gyro", "Gyroscope.", DatasetCols)
DatasetCols <- gsub("Mag", "Magnitude.", DatasetCols)
DatasetCols <- gsub("Freq$", "Frequency", DatasetCols)
DatasetCols <- gsub("Freq\\.", "Frequency.", DatasetCols)
DatasetCols <- gsub("\\.mean", "Mean", DatasetCols)
DatasetCols <- gsub("\\.std", "StandardDeviation", DatasetCols)
DatasetCols <- gsub("BodyBody", "Body", DatasetCols)

colnames(Dataset) <- DatasetCols

##############################################################################
# Step 5 - Create a second, independent tidy set with the average of each
# variable for each activity and each subject
##############################################################################

tidyData <-aggregate(. ~subjectId + activityId, Dataset, mean)

#Output the data of tidyData to file tidydata.txt

write.table(tidyData, file = "tidydata.txt",row.name=FALSE)
