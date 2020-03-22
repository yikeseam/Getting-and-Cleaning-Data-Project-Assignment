# Download the dataset from URL below to local folder.
# URL: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 1. Unzip the dataset to local folder "./data/UCI HAR Dataset".


# 2. Load dplyr package
library(dplyr)

# Steps 3 to 7 perform Reading data sets, follow by Assigning descriptive variable names. 
# The steps address Objective 1 - Merging data sets, and Objectvie 4 - Label data sets
# with descriptive variable names.
# This makes easier for reference and completion of subsequent Objectives.

# 3. Read activity_label.txt and assign description variable name to columns.
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt",
                              header = FALSE)
colnames(activity_labels) <- c("activity_id", "activity_name")


# 4. Read features.txt and assign description variable name to columns.
features <- read.table("./data/UCI HAR Dataset/features.txt",
                       header = FALSE)
colnames(features) <- c("feature_id", "feature_name")

# 5. Handle train data sets

# 5.1 Read subject_train.txt and assign description variable name to columns.
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt",
                            header = FALSE)
colnames(subject_train) <- "subject_id"

# 5.2 Read y_train.txt and assign description variable name to columns.
ytrain_label <- read.table("./data/UCI HAR Dataset/train/y_train.txt",
                            header = FALSE)
colnames(ytrain_label) = "activity_id"

# 5.3 Read X_train.txt and assign meaningful column names as in feature_name
xtrain_data <- read.table("./data/UCI HAR Dataset/train/X_train.txt",
                          header = FALSE)
colnames(xtrain_data) <- features[, 2]

# 5.4 Bind all columns for subject_train, ytrain_actvid and xtrain_data
xtrain_bind_data <- cbind(subject_train, ytrain_label, xtrain_data)

# 6. Handle test data sets

# 6.1 Read subject_test.txt and assign meaningful column names as in feature_name
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt",
                           header = FALSE)
colnames(subject_test) <- "subject_id"

# 6.2 Read y_test.txt and assign meaningful column names as in feature_name
ytest_label <- read.table("./data/UCI HAR Dataset/test/y_test.txt",
                           header = FALSE)
colnames(ytest_label) <- "activity_id"

# 6.3 Read X_test.txt and assign meaningful column names as in feature_name
xtest_data <- read.table("./data/UCI HAR Dataset/test/X_test.txt",
                         header = FALSE)
colnames(xtest_data) <- features[, 2]

# 6.4 Bind all columns for subject_test, ytest_label and xtest_data
xtest_bind_data <- cbind(subject_test, ytest_label, xtest_data)

# 7. Merge both binded train and test data sets
merge_train_test <- rbind(xtrain_bind_data, xtest_bind_data)

# 8. Objective 2 - Extracts only the measurements on the mean and standard deviation
# for each measurement
colnames <- colnames(merge_train_test)
select_col <- grepl("subject_id", colnames) | 
              grepl("activity_id", colnames) | 
              grepl(".*mean.*", colnames) | 
              grepl(".*std.*", colnames)
mergedb_mean_std <- merge_train_test[, select_col == TRUE]

# 9. Objective 3 - Uses descriptive activity names to name the activities in the data set
mergedb_actdesc <- merge(mergedb_mean_std, activity_labels,
                         by="activity_id", all.x = TRUE)

# 10. Objective 5 - Create tidy data set with average of each variable for each activity
# and each subject
tidy_dataset <- mergedb_actdesc %>%
                group_by(activity_name, subject_id) %>%
                summarise_each(mean)
# 10.1 Remove duplicated and non-descriptive activity label "activity_id"
tidy_dataset <- select(tidy_dataset, -activity_id)

# 10.2 Write tidy dataset to txt file
write.table(tidy_dataset, file = "./data/UCI HAR Dataset/tidy_dataset.txt",
            row.names = FALSE, col.names = TRUE)
