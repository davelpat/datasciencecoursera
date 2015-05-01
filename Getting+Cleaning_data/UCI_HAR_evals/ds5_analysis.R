# https://github.com/javiergutkowski/GettingAndCleaningData/blob/master/run_analysis.R#L51
# This section through line 5 was created to allow for manual entry of the working directory
# where the .zip file with Project data will reside
# GetWD <- toupper(readline("Enter the path where Project files will be/are located (ex: C:/GET_CLEAN_DATA) > "))
# fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# download.file(fileURL, destfile = paste(GetWD, "GCD_Project_Dataset.zip", sep = "/"))
# unzip("GCD_Project_Dataset.zip", overwrite = TRUE, unzip = "internal", setTimes = T)

#setwd (paste(GetWD, "UCI HAR Dataset", sep = "/"))

# Reading the "features" table first for the reason of organizing the layout of raw data set.
features <- read.table("./features.txt", quote="\"")
# Cleaning the downloaded data by converting all labels into lower characters and 
#removing confusing and extra characters like the parenthesis...
features$V2 <- gsub("[()]", "",tolower(features$V2))
# ... and the commas, dashes, etc. This I decided to do upfront so when I will read the raw data set, I can
# assign meaningful column names to it at the beginning stage.
features$V2 <- gsub("[..]|[,]|[-]", ".",features$V2)

# Reading the X, Y, and subject data sets.
test_X <- read.table("./test/x_test.txt", quote="\"",col.names = features$V2)
test_Y <- read.table("./test/y_test.txt", quote="\"",col.names = "act.label")
subj_test <- read.table("./test/subject_test.txt", quote="\"",col.names = "subject")
train_X <- read.table("./train/x_train.txt", quote="\"",col.names = features$V2)
train_Y <- read.table("./train/y_train.txt", quote="\"",col.names = "act.label")
subj_train <- read.table("./train/subject_train.txt", quote="\"",col.names = "subject")

# Combining the X datasets to form a base dataset with 10,299 rows and 561 columns.
comb_X <- rbind(test_X, train_X)
# Selecting only those columns that contain 'mean' and 'std' data
comb_X <- comb_X[,grep("mean|std", colnames(comb_X))]
# Combining the Y data sets
comb_Y <- rbind(test_Y, train_Y)
# Combining the subject data sets
comb_subj <- rbind(subj_test, subj_train)
# Joining all three datasets together
joined_df <- cbind(comb_X, comb_Y, comb_subj)

# Creating a lookup table with the Activity Names and Activity Labeles. It will be merged with the main Data set
activities <- read.table("./activity_labels.txt", quote="\"", col.names = c("act.label","activity.name"))
# Removing the '_' from the variable names per tidy data principles
activities$activity.name <- gsub("[_]", " ",tolower(activities$activity.name))

# Merging the 'activities' lookup table with the main data table 'joined_df' for the purpose of 
# labeling the observaton with appropriate activity names.
library(data.table)
tidy_dt <- data.table(merge(joined_df, activities, by.x = "act.label", by.y = "act.label"))

# Removing unnecessary and duplicate column 'act'label', which is now replaced with more descriptive
# 'activity.name' column
library(dplyr)
#tidy_dt <- data.table(select(tidy_df,-act.label))
tidy_dt <- data.table(select(tidy_dt,-act.label))

# Per the instructions in Step 5 of the Project assignment, 
#creating a final and "tidy data set with the average of each variable for each activity and each subject."
avg_dt <- tidy_dt[,lapply(.SD,mean),by="activity.name,subject"] %>%
  arrange(activity.name, subject)

# Saving the final tidy data set in 'tidy_dataset_w_means.txt' file for further upload into GitHub
write.table(avg_dt, file = "tidy_dataset_w_means.txt", row.names=FALSE)