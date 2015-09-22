
##########################################################################################################
##                      Coursera Getting and Cleaning Data Course Project                               ##
##                                      Stephen Tucker                                                  ##
# runAnalysis.r File Description:
# This script will perform the following steps on the UCI HAR Dataset downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 1. Initialise libraries
# 2. Import data into df
# 3. Merge the training and the test sets to create one data set.
# 4. Extract only the measurements on the mean and standard deviation for each measurement. 
# 5. Use descriptive activity names to name the activities in the data set
# 6. Appropriately label the data set with descriptive variable names. 
# 7. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##########################################################################################################

# Setup - Clean up workspace and variables
rm(list=ls())

# Step 1
# Initialise libraries/packages
###############################################################################
library(plyr)

# Step 2
# Load datasets into DFs
###############################################################################
x_train <- read.table("~/Documents/Coursera/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("~/Documents/Coursera/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("~/Documents/Coursera/UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("~/Documents/Coursera/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("~/Documents/Coursera/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("~/Documents/Coursera/UCI HAR Dataset/test/subject_test.txt")

features <- read.table("~/Documents/Coursera/UCI HAR Dataset/features.txt")

activities <- read.table("~/Documents/Coursera/UCI HAR Dataset/activity_labels.txt")

# Step 3
# Merge the training and test sets into one data set
###############################################################################
# create 'x' data table
x_data <- rbind(x_train, x_test)
# create 'y' data table
y_data <- rbind(y_train, y_test)
# create 'subject' data table
subject_data <- rbind(subject_train, subject_test)

# Step 4
# Extract only the measurements on the mean and standard deviation for each measurement
###############################################################################
# get only columns with mean() or std() in their names
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])

# subset the desired columns
x_data <- x_data[, mean_and_std_features]

# correct the column names
names(x_data) <- features[mean_and_std_features, 2]

# Step 5
# Use descriptive activity names to name the activities in the data set
###############################################################################
# update values with correct activity names
y_data[, 1] <- activities[y_data[, 1], 2]

# correct column name
names(y_data) <- "activity"

# Step 6
# Appropriately label the data set with descriptive variable names
###############################################################################
# correct column name
names(subject_data) <- "subject"

# bind all the data in a single data set
all_data <- cbind(x_data, y_data, subject_data)

# Step 7
# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject
###############################################################################
# 66 <- 68 columns but last two (activity & subject)
averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

# Outputs averages data in wd
write.table(averages_data, "averages_data.txt", row.name=FALSE)
