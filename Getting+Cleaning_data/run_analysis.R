# run_analysis.R does the following:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation
#    for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject.

# load required libraries
library("dplyr", lib.loc="~/R/win-library/3.1")

# load the data
setwd("~/GitHub/datasciencecoursera/data_science_repo/Getting+Cleaning_data")

# First, where is it
subject_test_file   <- "./UCI_HAR_Dataset/test/subject_test.txt"
activity_test_file  <- "./UCI_HAR_Dataset/test/y_test.txt"
data_test_file      <- "./UCI_HAR_Dataset/test/X_test.txt"
subject_train_file  <- "./UCI_HAR_Dataset/train/subject_train.txt"
activity_train_file <- "./UCI_HAR_Dataset/train/y_train.txt"
data_train_file     <- "./UCI_HAR_Dataset/train/X_train.txt"

activity_labels_file <- "./UCI_HAR_Dataset/activity_labels.txt"
data_labels_file     <- "./UCI_HAR_Dataset/features.txt"

# Read in the labels
tmp_df <- read.table(activity_labels_file, col.names = c("id", "label"), colClasses = c("integer", "character"))
activity_labels <- tmp_df$label

tmp_df <- read.table(data_labels_file, col.names = c("id", "label"), colClasses = c("integer", "character"))
data_labels     <- tmp_df$label
rm(tmp_df)

# Create the first data set (steps 1 - 4)
# data join: cbind subject, y, x; rbind test, train
# give variables mnemonic names
combined_data <- tbl_df(
  rbind(
    cbind(
      read.table(subject_test_file, col.names = "Subject"),
      read.table(activity_test_file, col.names = "Activity"),
      read.table(data_test_file, col.names = data_labels)),
    cbind(
      read.table(subject_train_file, col.names = "Subject"),
      read.table(activity_train_file, col.names = "Activity"),
      read.table(data_train_file, col.names = data_labels))))

# select subject, activity, mean, std
# first two variables are the subject and activity
std_mean_data <- select(combined_data, 1:2, contains("mean", ignore.case = FALSE), contains("std"))

# map the activities
std_mean_data <- mutate(std_mean_data, Activity = activity_labels[Activity])

# Create second data set