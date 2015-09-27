Get and Clean data assignment - Codebook

This file describes the variables, the data, and any transformations performed on the dataset

The original dataset is:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
(source: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Data location expected for script to run is: ~/Documents/Coursera/UCI HAR Dataset/ (will be referred to as "data" below, e.g. data/train)

The run_analysis.R script performs the following steps to clean and transform the data:


1. Initialise libraries/packages (plyr)
2. Read X_train.txt, y_train.txt and subject_train.txt from the "data/train/" folder and store them in x_train, y_train and subject_train
  -Read X_test.txt, y_test.txt and subject_test.txt from the "data/test" folder and store them in x_test, y_test and subject_test
  -Read features.txt from the "data/features" and store in features
  -Read activities.txt from the "data/activities" and store in activities
3. Merge the training and test sets into one dataset (x_train, x_test -> x_data ; y_train, y_test -> y_data ; subject_train, subject_test -> subject_data)
4. Extract only the measurements on the mean and standard deviation for each measurement and create subset
5. Use descriptive activity names to name the activities in the data set
6. Label the dataset with subject columns
7. Create a second, independent tidy data set with the average of each variable, for each activity and each subject
8. Output the averages in the wd with write.table - filename: "averages_data.txt", with no row name.
