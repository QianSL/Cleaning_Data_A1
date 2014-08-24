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
   - 1st column: subject
   - 2nd column: activity
   - 3~563rd column: those features
   - 564~1715th column: Inertial signals in the alphabetic sequence of file name
- Row:
   - 1~7352nd row: data from train
   - 7353~10299th row: data from test

## Step2 Extracts ...
'Data_2' is created for this step, it's done by subset from 'Data'.
Each element in the 2nd column of *features.txt* contains *mean* or *std* is considered as the measurements can fulfill the requirements of this step, 


