# Introduction
This is Coursera "Getting and Cleaning Data" course, Week 4 peer-graded project assignment.

The purpose of this project is for the learner to demonstrate the ability to collect, work with, and clean a data set.

# Dataset Input
The data for the project represent data collected from the experiments that have been carried out with a group of 30 volunteers. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, it captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 

A full description  is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

URL below is the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Project Output
The project output includes the following items and to keep in a Github repository:
1. Tidy Dataset in txt format
2. CodeBook.md that describes the variables and related information of the Tidy Dataset.
3. README.md that explains the analysis files is clear and understandable.
4. R Script called run_analysis.R that perform the steps and achieve the project assignment objectives.

# Objectives of R Script "run_analysis.R"
The run_analysis.R does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Assumption
Current working directory is "C:/Users/.../Documents/". where ... refers to username of the workstation login user.

# Process Flows
1. Download data zip file to local folder and unzipped to folder "./data/UCI HAR Dataset" outside RStudio.
2. Start process in RStudio by loading dplyr package , as some R scripts use dplyr approach.

Note: Steps 3 to 7 perform Reading datasets, follow by Assigning descriptive variable names. By doing so, the steps address both Objective 1 (Merging data sets), and Objectvie 4 (Label data sets with descriptive variable names).
This also makes easier for reference and completion of the rest of Objectives.

3. Read activity_label.txt and assign description variable name to columns.
4. Read features.txt and assign description variable name to columns.
5. Handle train datasets
5.1 Read subject_train.txt and assign description variable name to columns.
5.2 Read y_train.txt and assign description variable name to columns.
5.3 Read X_train.txt and assign meaningful column names as in feature_name
5.4 Bind all columns for subject_train, ytrain_actvid and xtrain_data
6. Handle test datasets
6.1 Read subject_test.txt and assign meaningful column names as in feature_name
   6.2 Read y_test.txt and assign meaningful column names as in feature_name
   6.3 Read X_test.txt and assign meaningful column names as in feature_name
   6.4 Bind all columns for subject_test, ytest_label and xtest_data
7. Merge both binded train and test data sets
8. Objective 2 - Extracts only the measurements on the mean and standard deviation for each measurement
9. Objective 3 - Uses descriptive activity names to name the activities in the data set
10. Objective 5 - Create tidy data set with average of each variable for each activity and each subject
    10.1 Since there is already "activity_name" in the dataset, "activity_id" is somehow duplicated and no necessary, hence removed it.
    10.2 Write tidy dataset to tidy_dataset.txt file

# Tidy Dataset
The R Scripts "run_analysis.R" generates a tidy dataset that meets the principles (Hadley 2014) of: 
1.	Each variable forms a column
2.	Each observation forms a row
3.	Each type of observational unit forms a table

# Reference
Hadley Wickham (2014) "Tidy Data", Journal of Statistical Software, vol.59, issue 10, page 4
