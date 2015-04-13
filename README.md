# GettingAndCleaningData
Coursera Data Science Track - Getting and cleaning data course project
#
 Coursera Data Science track

 Getting and cleaning data

 Course project

 This script will clean up data from the UCI HAR dataset and create an output file
 containing a tidy data set comprising the mean of the following variables for each combination
 of subject and activity:

 Column Name
 ------ ---------------------------
 201    tBodyAccMag-mean()
 202    tBodyAccMag-std()
 214    tGravityAccMag-mean()
 215    tGravityAccMag-std()
 227    tBodyAccJerkMag-mean()
 228    tBodyAccJerkMag-std()
 240    tBodyGyroMag-mean()
 241    tBodyGyroMag-std()
 253    tBodyGyroJerkMag-mean()
 254    tBodyGyroJerkMag-std()
 503    fBodyAccMag-mean()
 504    fBodyAccMag-std()
 516    fBodyBodyAccJerkMag-mean()
 517    fBodyBodyAccJerkMag-std()
 529    fBodyBodyGyroMag-mean()
 530    fBodyBodyGyroMag-std()
 542    fBodyBodyGyroJerkMag-mean()
 543    fBodyBodyGyroJerkMag-std()

 For details of the datasets see the README.txt in the source data package
 which can be downloaded from:
 https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
 and the relevant web page at:
 http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

 The script uses the dplyr package which will support
 the summarisation stage of the process.  This package is 
 loaded at the top of the script.

 The script assumes that the unzipped data package is present in the current working directory
 and will make sure it is there before proceeding

 The files that will be read from the data package are as follows:

./UCI HAR Dataset/test/X_test.txt contains the results from the test group

./UCI HAR Dataset/test/subject_test.txt identifies the subject for each set of test results

./UCI HAR Dataset/test/y_test.txt identifies the activity undertaken for each set of test results

./UCI HAR Dataset/train/X_train.txt contains the results from the training group

./UCI HAR Dataset/train/subject_train.txt identifies the subject for each set of training results

./UCI HAR Dataset/train/y_train.txt identifies the activity undertaken for each set of training results

./UCI HAR Dataset/activity_labels.txt provides the label which describes each activity 

 The main task for the script is to select the columns specified from the test and training results files and combine them as a single data table.  Whilst doing this it will also lookup the subject fo each set of results and the description for the relevant activity and include those in the combined data table.

 Once the data is in a single data table it needs to be tidied up before creating the final output file.

 Using the dplry package the script will group the data table by subject and activity
 before summarising the data for each level of grouping by calculating the mean of each column.
 NA's will be removed from the data table when calculating the means.

 Finally the summarised dataset is written to the text file 'MeansBySubjectAndActivity.txt'
 in the working directory

