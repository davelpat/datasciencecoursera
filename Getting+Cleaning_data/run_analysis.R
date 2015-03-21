# run_analysis.R does the following:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation
#    for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject.

# load required libraries
library("dplyr")

# load the data
# First, where is it
setwd("~/GitHub/datasciencecoursera/data_science_repo/Getting+Cleaning_data")

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

# Clean up as we proceed
rm(tmp_df)

# Create the first data set (steps 1 - 4)
# data join: cbind subject, y, x; rbind test, train
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
# Note that there are 7 variable names that appear to be the formula for calculating angles
#   and have "Mean" in the formula, but these are not mean variables. We are only interested in 
#   variables that are means (and standard deviations) and these are all lower cased
std_mean_data <- select(combined_data, Subject, Activity, contains("mean", ignore.case = FALSE), contains("std"))

# Clean up as we proceed
rm(combined_data)

# give variables mnemonic names
# Get the syntactically correct variable names from the original data set, then
#  Remove the trailing periods ('.') and the extra periods in the midst of the names
#  left over from read.table making the names syntactically correct
#  Finally, convert the list to a vector
new_names <- names(std_mean_data) %>%
  lapply(sub, pattern="[.]+$", replacement="") %>%
  lapply(gsub, pattern="[.]+", replacement=".") %>%
  unlist
# Rename the variables in the target data set with the new names
names(std_mean_data) <- new_names

# map the activities
# Use the activity code to look up the activity name in the list they provide
std_mean_data <- mutate(std_mean_data, Activity = activity_labels[Activity])

# Now, create second data set
# First, group the means and standard deviation data subset
# Then summarize the mean of the groups across each variable
ave_std_mean_data <- std_mean_data %>%
  group_by(Subject, Activity) %>%
  summarise_each(funs(mean))