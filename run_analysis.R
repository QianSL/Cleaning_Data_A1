
# Personally, I think the requirement is not so clear, so hope we share the same
# understanding on it.

# Assume the .zip file is in the working directory, let's read each data file 
# possible to R
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

# merge data together, first 'train', then 'test', then together.
# the 'Data' has a structure like this:
#Column:
#   1st column: subject
#   2nd column: activity
#   3~563rd column: those features
#   564~1715th column: Inertial signals in the alphabetic sequence of file name
#Row:
#   1~7352nd row: data for train
#   7353~10299th row: data for test
cbind(subject_train, y_train, X_train, as.data.frame(Inertial_signal_train)) -> 
    train_data
cbind(subject_test, y_test, X_test, as.data.frame(Inertial_signal_test)) -> 
    test_data
rbind(train_data, test_data) -> Data

# "Extracts only the measurements on the mean and standard deviation for each 
# measurement"
# I want to assume the instructor want all mean and standard deviation(std) data 
# according to the feature file. At the same time, I want to keep the subject and
# activity column, as "step 3' ask to 'name the activities'.
Data[, c(1,2,grep('mean|std', features[,2]) + 2)] -> Data_2

# 'Uses descriptive activity names to name the activities in the data set'
# Using names in "activity_labels" to substitute the '1~6' in data set
Data_2$V1.1 <- as.factor(Data_2$V1.1)
levels(Data_2$V1.1) <- levels(activity_labels[,2])

# 'Appropriately labels the data set with descriptive variable names.'
# Using the name from 'features', except the first 2 column are "subject" and
# "activities"
colnames(Data_2) <- c('subject','activities',as.character(
    features[grep('mean|std', features[,2]),2]))

# 'Creates a second, independent tidy data set with the average of each 
# variable for each activity and each subject.'
# Using 'reshape2' to melt and cast the 'Data_2', to get the mean value of each
# variable for each activity and each subject.
# Data_5 is the data set we want
library(reshape2)
Data_melt <- melt(Data_2, id=c('subject','activities'))
Data_5 <- dcast(Data_melt, subject + activities ~ variable, mean)
write.table(Data_5, file='Tidy_data', row.name=FALSE)






