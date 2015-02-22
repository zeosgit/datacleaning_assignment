## The following R script addresses the key objectives of Course Assignment -
## Objective 1 - Merges the training and the test sets to create one data set
## Objective 2 - Appropriately labels the data set with descriptive variable names
## Objective 3 - Extracts only the measurements on the mean and standard deviation 
##               for each measurement. 
## Objective 4 - Uses descriptive activity names to name the activities in the data set
## Objective 5 - From the data set in step 4, creates a second, independent tidy data 
##               set with the average of each variable for each activity and each subject.
## The order in which these objectives are met vary depending on the logic used
## The working directory for this code should be set to "UCI HAR Dataset" folder of input data
## This code also requiers plyr library

library(plyr)

## Load the names of the columns of main feature data

feature <- scan("features.txt", what = list(NULL, name = character()))
feature_name <- feature$name

## Load the activity IDs and the associated labels from activity file

activity_label <- read.table("activity_labels.txt", header=FALSE,col.names = c("activity","activity_name"))

## Work with the test data addressing the following -
##    1. Load the data and assign feature names as column names to the data
##    2. Filter all columns except the ones that have mean and standard deviation
##    3. Load the subject records and the activity records from subect_test.txt file
##       and y_test.txt file. Then clean up the y_test.txt and update with activity labels
##    4. Merge the three files to create the final file for test data

X_test_data <- read.table("test\\X_test.txt",header=FALSE)
colnames(X_test_data) <- feature_name

X_test_data <- X_test_data[,grepl(".(mean|std|Mean).",names(X_test_data))]

subject_test <- read.table("test\\subject_test.txt",header=FALSE,col.names = c("subject_ID"))

Y_test <- read.table("test\\y_test.txt",header=FALSE,col.names = c("activity"))
Y_test <- merge(Y_test,activity_label)

X_test_data <- cbind(subject_test,Y_test$activity_name,X_test_data)
colnames(X_test_data)[2] <- 'activity'

## Work with the train data addressing the following -
##    1. Load the data and assign feature names as column names to the data
##    2. Filter all columns except the ones that have mean and standard deviation
##    3. Load the subject records and the activity records from subect_train.txt file
##       and y_train.txt file. Then clean up the y_train.txt and update with activity labels
##    4. Merge the three files to create the final file for train data

X_train_data <- read.table("train\\X_train.txt",header=FALSE)
colnames(X_train_data) <- feature_name

X_train_data <- X_train_data[,grepl(".(mean|std|Mean).",names(X_train_data))]

subject_train <- read.table("train\\subject_train.txt",header=FALSE,col.names = c("subject_ID"))

Y_train <- read.table("train\\y_train.txt",header=FALSE,col.names = c("activity"))
Y_train <- merge(Y_train,activity_label)

X_train_data <- cbind(subject_train,Y_train$activity_name,X_train_data)
colnames(X_train_data)[2] <- 'activity'

## Merage the test and train data to create the consolidated dataset

merged_data <- rbind(X_train_data,X_test_data)

## Apply the average function and summarize by Sujbect and Activity

final_output <- ddply(merged_data,c('subject_ID','activity'),numcolwise(mean))

## Output the result in required format

write.table(final_output,file='final_summary.txt',row.names = FALSE)
