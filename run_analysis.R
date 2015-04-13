#--------------------------------------
# run_analysis.R
#
# Coursera Data Science track
#
# Getting and cleaning data
#
# Course project
#---------------------------------------
#
# This script will clean up data from the UCI HAR dataset and create an output file
# containing a tidy data set comprising the mean of the following variables for each combination
# of subject and activity:
#
# Column Name
# ------ ---------------------------
# 201    tBodyAccMag-mean()
# 202    tBodyAccMag-std()
# 214    tGravityAccMag-mean()
# 215    tGravityAccMag-std()
# 227    tBodyAccJerkMag-mean()
# 228    tBodyAccJerkMag-std()
# 240    tBodyGyroMag-mean()
# 241    tBodyGyroMag-std()
# 253    tBodyGyroJerkMag-mean()
# 254    tBodyGyroJerkMag-std()
# 503    fBodyAccMag-mean()
# 504    fBodyAccMag-std()
# 516    fBodyBodyAccJerkMag-mean()
# 517    fBodyBodyAccJerkMag-std()
# 529    fBodyBodyGyroMag-mean()
# 530    fBodyBodyGyroMag-std()
# 542    fBodyBodyGyroJerkMag-mean()
# 543    fBodyBodyGyroJerkMag-std()
#
# For details of the datasets see the README.txt in the source data package
# which can be downloaded from:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# and the relevant web page at:
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#
#---------------------------------------------
# To start, load the dplyr package which will support
# the summarisation stage of the process
#
library(dplyr)
#
# The script assumes that the unzipped data package is present in the current working directory
# Make sure it is there before proceeding
#
if(!file.exists("UCI HAR Dataset")) {
    stop("Directory 'UCI HAR Dataset' not found; The unzipped Samsung dataset must be present in the working directory.")
}
#
# Define the files that we are going to need from the data package
#
# This file contains the results from the test group
testdatafile <- "./UCI HAR Dataset/test/X_test.txt"
# This file identifies the subject for each set of test results
testsubjectfile <- "./UCI HAR Dataset/test/subject_test.txt"
# This file identifies the activity undertaken for each set of test results
testactivityfile <- "./UCI HAR Dataset/test/y_test.txt"
# This file contains the results from the training group
traindatafile <- "./UCI HAR Dataset/train/X_train.txt"
# This file identifies the subject for each set of training results
trainsubjectfile <- "./UCI HAR Dataset/train/subject_train.txt"
# This file identifies the activity undertaken for each set of training results
trainactivityfile <- "./UCI HAR Dataset/train/y_train.txt"
# This file provides the label which describes each activity 
activitylabelfile <- "./UCI HAR Dataset/activity_labels.txt"
# 
# For each of these files, check that it is there and
# then read from disk
#
if(file.exists(testdatafile)) {
    message("Reading test dataset")
    testdata <- read.table(testdatafile,colClasses="numeric")
} else {
    stop("Test dataset not found")
}
if(file.exists(testsubjectfile)) {
    message("Reading test subject dataset")
    testsubject <- read.table(testsubjectfile)
} else {
    stop("Test subject data not found")
}
if(file.exists(testactivityfile)) {
    message("Reading test activity dataset")
    testactivity <- read.table(testactivityfile)
} else {
    stop("Test activity data not found")
}
if(file.exists(traindatafile)) {
    message("Reading training dataset")
    traindata <- read.table(traindatafile,colClasses="numeric")
} else {
    stop("Training dataset not found")
}
if(file.exists(trainsubjectfile)) {
    message("Reading training subject dataset")
    trainsubject <- read.table(trainsubjectfile)
} else {
    stop("Training subject data not found")
}
if(file.exists(trainactivityfile)) {
    message("Reading training activity dataset")
    trainactivity <- read.table(trainactivityfile)
} else {
    stop("Training activity data not found")
}
if(file.exists(activitylabelfile)) {
    message("Reading activity label dataset")
    activitylabel <- read.table(activitylabelfile)
} else {
    stop("Activity label data not found")
}
#
# Now extract the relevant columns from each of the result sets and match with the relevant subject
# and activity label
#
# First create an empty object to contain the combined test and training data
#
outputset <- NULL
# 
# Append the test data as a data frame
#  
outputset <- rbind(outputset,data.frame("tBodyAccMag.mean"=testdata[,201],"tBodyAccMag.std"=testdata[,202],
                                        "tGravityAccMag.mean"=testdata[,214],"tGravityAccMag.std"=testdata[,215],
                                        "tBodyAccJerkMag.mean"=testdata[,227],"tBodyAccJerkMag.std"=testdata[,228],
                                        "tBodyGyroMag.mean"=testdata[,240],"tBodyGyroMag.std"=testdata[,241],
                                        "tBodyGyroJerkMag.mean"=testdata[,253],"tBodyGyroJerkMag.std"=testdata[,254],
                                        "fBodyAccMag.mean"=testdata[,503],"fBodyAccMag.std"=testdata[,504],
                                        "fBodyBodyAccJerkMag.mean"=testdata[,516],"fBodyBodyAccJerkMag.std"=testdata[,517],
                                        "fBodyBodyGyroMag.mean"=testdata[,529],"fBodyBodyGyroMag.std"=testdata[,530],
                                        "fBodyBodyGyroJerkMag.mean"=testdata[,542],"fBodyBodyGyroJerkMag.std"=testdata[,543],
                                        "subject"=testsubject[,1],"activity"=activitylabel[testactivity[,1],2]
                                        ))
# 
# Append the training data to the data frame
#
outputset <- rbind(outputset,data.frame("tBodyAccMag.mean"=traindata[,201],"tBodyAccMag.std"=traindata[,202],
                                        "tGravityAccMag.mean"=traindata[,214],"tGravityAccMag.std"=traindata[,215],
                                        "tBodyAccJerkMag.mean"=traindata[,227],"tBodyAccJerkMag.std"=traindata[,228],
                                        "tBodyGyroMag.mean"=traindata[,240],"tBodyGyroMag.std"=traindata[,241],
                                        "tBodyGyroJerkMag.mean"=traindata[,253],"tBodyGyroJerkMag.std"=traindata[,254],
                                        "fBodyAccMag.mean"=traindata[,503],"fBodyAccMag.std"=traindata[,504],
                                        "fBodyBodyAccJerkMag.mean"=traindata[,516],"fBodyBodyAccJerkMag.std"=traindata[,517],
                                        "fBodyBodyGyroMag.mean"=traindata[,529],"fBodyBodyGyroMag.std"=traindata[,530],
                                        "fBodyBodyGyroJerkMag.mean"=traindata[,542],"fBodyBodyGyroJerkMag.std"=traindata[,543],
                                        "subject"=trainsubject[,1],"activity"=activitylabel[trainactivity[,1],2]
))
#
# now using the dplry package, group the resulting dataset by subject and activity
#
grpby <- group_by(outputset,subject,activity)
#
# and then summarise the data for each level of grouping by calculating the mean of each column
# removing NA's
#
meansumm <- summarize(grpby,
                      "tBodyAccMag.mean"=mean(tBodyAccMag.mean, na.rm = TRUE),
                      "tBodyAccMag.std"=mean(tBodyAccMag.std, na.rm = TRUE),
                      "tGravityAccMag.mean"=mean(tGravityAccMag.mean, na.rm = TRUE),
                      "tGravityAccMag.std"=mean(tGravityAccMag.std, na.rm = TRUE),
                      "tBodyAccJerkMag.mean"=mean(tBodyAccJerkMag.mean, na.rm = TRUE),
                      "tBodyAccJerkMag.std"=mean(tBodyAccJerkMag.std, na.rm = TRUE),
                      "tBodyGyroMag.mean"=mean(tBodyGyroMag.mean, na.rm = TRUE),
                      "tBodyGyroMag.std"=mean(tBodyGyroMag.std, na.rm = TRUE),
                      "tBodyGyroJerkMag.mean"=mean(tBodyGyroJerkMag.mean, na.rm = TRUE),
                      "tBodyGyroJerkMag.std"=mean(tBodyGyroJerkMag.std, na.rm = TRUE),
                      "fBodyAccMag.mean"=mean(fBodyAccMag.mean, na.rm = TRUE),
                      "fBodyAccMag.std"=mean(fBodyAccMag.std, na.rm = TRUE),
                      "fBodyBodyAccJerkMag.mean"=mean(fBodyBodyAccJerkMag.mean, na.rm = TRUE),
                      "fBodyBodyAccJerkMag.std"=mean(fBodyBodyAccJerkMag.std, na.rm = TRUE),
                      "fBodyBodyGyroMag.mean"=mean(fBodyBodyGyroMag.mean, na.rm = TRUE),
                      "fBodyBodyGyroMag.std"=mean(fBodyBodyGyroMag.std, na.rm = TRUE),
                      "fBodyBodyGyroJerkMag.mean"=mean(fBodyBodyGyroJerkMag.mean, na.rm = TRUE),
                      "fBodyBodyGyroJerkMag.std"=mean(fBodyBodyGyroJerkMag.std, na.rm = TRUE)
                      )
#
# Finally write the resulting dataset to a text file in the working directory
#
outfile = "./MeansBySubjectAndActivity.txt"
message("Writing summarised output file:")
write.table(meansumm,file=outfile,row.name=FALSE)
message(outfile)


