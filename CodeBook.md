# Code Book

Generally, the data handling process was made according to the requirement of the couse project.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

**No treatments toward units was made in the whole process.**

## Step1 Merges ... 
'Data' is created for this step, the structure is:
- Column:
   - 1st column: subject, coming from 'subject_test.txt' and 'subject_train.txt';
   - 2nd column: activity, coming from 'y_test.txt' and 'y_train.txt';
   - 3~563rd column: those features, coming from 'X_test.txt' and 'X_train.txt';
   - 564~1715th column: Inertial signals in the alphabetic sequence of file name, coming from all files in '/test/Inertial Signal' and '/train/Inertial Signal';
- Row:
   - 1~7352nd row: data from '/train';
   - 7353~10299th row: data from '/test';

## Step2 Extracts ...
'Data_2' is created for this step, it's done by subset from 'Data'.
Each element in the 2nd column of *features.txt* contains *mean* or *std* is considered as the measurements can fulfill the requirements of this step. The data from 3~563rd column of 'Data' are extracted according to the elements selected. Also the first 2 colomn are kept for later analysis.

## Step3 Uses ... 
Use the name given by 'activity_labels.txt' to rename the 2nd column of 'Data_2', which is activity code coming from 'y_test.txt' and 'y_train.txt'

## Step4 Appropriately ...
To rename the column name of 'Data_2':
- 1st column, 'subject'
- 2nd column, 'activities'
- 3~last column, according to step2, getting the name of selected elements, and assign them to the column name. As those column are selected according to these elements, they should match each other.

## Step5 Creates ...
Using *melt* and *dcast* from library *reshape2* to create the new data set.
'Data_melt' is created by *melt* function, then 'Data_5' is created with *dcast* function.
So, the column structure of 'Data_5' is same as 'Data_2', except the variables are the average value for different 'activity' and 'subject' combination.

Then, a file with the name 'Tidy_data.txt' according to Data_5 was created for later uploading.


** For more information, please refer to the comments and code in 'run_analysis.R' **






