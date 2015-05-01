# https://github.com/yiminchin/Getting-Cleaning-Data-Course-Project/blob/master/run_analysis.R
dataset_url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataset_url,"getdata-projectfiles-UCI HAR Dataset.zip")
unzip("getdata-projectfiles-UCI HAR Dataset.zip", exdir = "hardata")
install.packages("reshape2")
library(reshape2)

data_train_x<-read.table("hardata/UCI HAR Dataset/train/X_train.txt",header=FALSE)
data_test_x<-read.table("hardata/UCI HAR Dataset/test/X_test.txt",header=FALSE)
data_train_y<-read.table("hardata/UCI HAR Dataset/train/Y_train.txt",header=FALSE)
data_test_y<-read.table("hardata/UCI HAR Dataset/test/Y_test.txt",header=FALSE)
data_train_sub<-read.table("hardata/UCI HAR Dataset/train/subject_train.txt",header=FALSE)
data_test_sub<-read.table("hardata/UCI HAR Dataset/test/subject_test.txt",header=FALSE)

data_train<-cbind(data_train_sub,data_train_y,data_train_x)
data_test<-cbind(data_test_sub,data_test_y,data_test_x)
data_combined<-rbind(data_train,data_test)

features<-read.table("hardata/UCI HAR Dataset/features.txt")
feature_names<-as.character(features[,2])

labels<-read.table("hardata/UCI HAR Dataset/activity_labels.txt",col.names=c("activity_id","activity_names"))

names(data_combined)<-c("sub_id","activity_id",feature_names)

mean_col_chk<- grep("mean",names(data_combined),ignore.case=TRUE)
mean_col_names<- names(data_combined)[mean_col_chk]
std_col_chk<- grep("std",names(data_combined),ignore.case=TRUE)
std_col_names<- names(data_combined)[std_col_chk]
extracted_data<-data_combined[,c("sub_id","activity_id",mean_col_names,std_col_names)]
activity_desc<-merge(extracted_data,labels,by.x="activity_id", by.y="activity_id",all=TRUE)
melted_data<-melt(activity_desc,c("sub_id","activity_id","activity_names"))
final_data<-dcast(melted_data,sub_id+activity_id+activity_names~variable,mean)
write.table(final_data,"hardata/UCI HAR Dataset/tidied_data.txt",row.name=FALSE)