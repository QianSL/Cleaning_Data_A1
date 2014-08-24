##Cleaning_Data_A1
================

*This is the course project of 'Getting and cleaning Data' in Coursera*

###Background information: (quote from website of the course)

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article .   

Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:  

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)  

Here are the data for the project:  

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)  

 You should create one R script called run_analysis.R that does the following.  
1.Merges the training and the test sets to create one data set.  
2.Extracts only the measurements on the mean and standard deviation for each measurement.  
3.Uses descriptive activity names to name the activities in the data set.  
4.Appropriately labels the data set with descriptive variable names.  
5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

###Preparation
As it mentioned in the submit requirement of course project: 
"*...The code should have a file run_analysis.R in the main directory that can be run as long as the Samsung data is in your working directory. ...*"  
I assume the '.zip' file needed is already prepared in your working directory.

### run_analysis.R
The cript is handling data like this:

1. Assume the .zip file is in the working directory, let's read each data file possible to R

rm(list=ls())  
unzip('getdata-projectfiles-UCI HAR Dataset.zip')  
read.table('UCI HAR Dataset/features.txt', sep='') -> features  
read.table('UCI HAR Dataset/activity_labels.txt', sep='') -> activity_labels  
read.table('UCI HAR Dataset/test/subject_test.txt', sep='') -> subject_test  
read.table('UCI HAR Dataset/test/X_test.txt', sep='') -> X_test  
read.table('UCI HAR Dataset/test/y_test.txt', sep='') -> y_test  
list.files('UCI HAR Dataset/test/Inertial Signals') -> signal_name_test  
lapply(paste('UCI HAR Dataset/test/Inertial Signals/', signal_name_test, sep=''), 
       read.table) -> Inertial_signal_test  
read.table('UCI HAR Dataset/train/subject_train.txt', sep='') -> subject_train  
read.table('UCI HAR Dataset/train/X_train.txt', sep='') -> X_train  
read.table('UCI HAR Dataset/train/y_train.txt', sep='') -> y_train  
list.files('UCI HAR Dataset/train/Inertial Signals') -> signal_name_train  
lapply(paste('UCI HAR Dataset/train/Inertial Signals/', signal_name_train, sep=''), 
       read.table) -> Inertial_signal_train

2. Merge data together, first 'train', then 'test', then together.

cbind(subject_train, y_train, X_train, as.data.frame(Inertial_signal_train)) -> 
    train_data  
cbind(subject_test, y_test, X_test, as.data.frame(Inertial_signal_test)) -> 
    test_data  
rbind(train_data, test_data) -> Data


3. Extracts only the measurements on the mean and standard deviation for each measurement. Here,I want to assume the instructor want all mean and standard deviation(std) data according to the feature file. At the same time, I want to keep the subject and activity column, as "step 3' ask to 'name the activities'.

Data[, c(1,2,grep('mean|std', features[,2]) + 2)] -> Data_2

4. Uses descriptive activity names to name the activities in the data set, so using names in "activity_labels" to substitute the '1~6' in data set
Data_2$V1.1 <- as.factor(Data_2$V1.1)  
levels(Data_2$V1.1) <- levels(activity_labels[,2])

5. Appropriately labels the data set with descriptive variable names. Using the name from 'features', except the first 2 column are "subject" and "activities"

colnames(Data_2) <- c('subject','activities',as.character(
    features[grep('mean|std', features[,2]),2]))

6. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. Using 'reshape2' to melt and cast the 'Data_2', to get the mean value of each variable for each activity and each subject. Data_5 is the data set we want

library(reshape2)  
Data_melt <- melt(Data_2, id=c('subject','activities'))  
Data_5 <- dcast(Data_melt, subject + activities ~ variable, mean)

7. Prepare a .txt file for uploading, write the Data_5 to 'Tidy_data.txt'.

write.table(Data_5, file='Tidy_data.txt', row.name=FALSE)













