=====================================================================================
Course Assignment - Getting & Cleaning Data
=====================================================================================

The following provides the details on how the data for the course
assignment data set was cleansed and summarized as per the 
assignment objectives which were -

Objective 1 - Merges the training and the test sets to create one data set
Objective 2 - Appropriately labels the data set with descriptive variable names
Objective 3 - Extracts only the measurements on the mean and standard deviation for 
	      each measurement. 
Objective 4 - Uses descriptive activity names to name the activities in the data set
Objective 5 - From the data set in step 4, creates a second, independent tidy data 
              set with the average of each variable for each activity and each subject.

Please note the following regarding the code and logic developed -
- The order in which these objectives are met in the logic vary
- The working directory for this code should be set to "UCI HAR Dataset" folder 
- This code also requiers plyr library

Following represents the steps for creating the final output set -

1. Load the names of the columns of main feature data from the features.txt file
2. Load the activity IDs and the associated labels from activity_labels.txt file
3. Process the test data set followed by the train data set using the following steps
    a. Load the data and assign feature names as column names to the data
    b. Filter all columns except the ones that have mean and standard deviation
    c. Load the subject records and the activity records from subect_XXXX.txt file
       and y_XXXX.txt file. Then clean up the y_XXXX.txt and update with activity labels
    d. Merge the three files to create the final file for test or train data
4. Merage the test and train data to create the consolidated dataset
5. Apply the average function and summarize by Sujbect and Activity and finally
   create the output file