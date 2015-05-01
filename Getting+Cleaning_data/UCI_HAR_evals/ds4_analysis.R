# https://github.com/jomit/Getting-and-Cleaning-Data-/blob/master/run_analysis.R
========================================================================================================
  # Script to create tidy dataset from UCI Human Activity Recognition train & tests datasets
  ========================================================================================================
  # Steps to create the tidy dataset:    
  # -------------------------------------------------------------------------------
# 1.Merges the training and the test sets to create one data set.
# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3.Uses descriptive activity names to name the activities in the data set
# 4.Appropriately labels the data set with descriptive variable names. 
# 5.From the data set in step 4, creates a second, independent tidy data set with the average of 
#   each variable for each activity and each subject.

#Note: The script can only be run as long as the UCI HAR Dataset is in your working directory.

# Read train and test sensor data from files
trainData <- read.table("UCI HAR Dataset/train/X_train.txt",row.names=NULL)
testData <- read.table("UCI HAR Dataset/test/X_test.txt",row.names=NULL)

# Merge the training and the test sensor data.
sensorData <- rbind(trainData,testData)

# Read train and test activity data from files
trainActivity <- read.table("UCI HAR Dataset/train/y_train.txt")
testActivity <- read.table("UCI HAR Dataset/test/y_test.txt")

# Merge the training and the test activity data.
activityData <- rbind(trainActivity,testActivity)

# Change column name of activity data
colnames(activityData) <- "Activity"

# Read train and test subject data from files
trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt")
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Merge the training and the test subject data.
subjectData <- rbind(trainSubject,testSubject)

# Change column name of subject data
colnames(subjectData) <- "Subject"

# Change column names of sensory data with descriptive variable names from features file. 
features <- read.table("UCI HAR Dataset/features.txt")
colnames(sensorData) <- features$V2

# Merge all sensor, subject and activity data
allData <- cbind(sensorData,subjectData,activityData)


# select features which has 'mean()' in the name
meancolumns <- features[grep("mean()",features$V2,fixed=TRUE),]

# select features which has 'std()' in the name
stdcolumns <- features[grep("std()",features$V2,fixed=TRUE),]

# select columns which match the mean, std names along with Subject and Activity and create a new data frame
meanstdData <- allData[,c(as.character(meancolumns$V2),as.character(stdcolumns$V2),"Subject","Activity")]


# get activity labels from labels file 
activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt")

# change activity ids to descriptive activity names 
meanstdData$Activity <- as.character(activitylabels$V2[match(meanstdData$Activity,activitylabels$V1)])


# create a second, independent tidy data set with the average of each variable for each activity and each subject.
tidyData <- aggregate(meanstdData, by=list(subject=meanstdData$Subject, activity=meanstdData$Activity),FUN=mean,na.rm=TRUE)

# remove the duplicate Subject and Activity columns from the end.
tidyData = tidyData[,c(1:68)]

# create a txt file with the tidy data.
write.table(x=tidyData, file = "UCI HAR Tidy Dataset.txt", row.name = FALSE)