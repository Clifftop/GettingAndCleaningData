##
## Getting and Cleaning Data Course Project
## 

library(dplyr)

##
## Read in all the relevant data files
##

# Read in the relevant files from the "test" data directoryCode
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Read in the relevant files from the "train" data directory
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# Read in the relevant files from the top level
features <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")


## ----------
## 1.  Merge the training and the test sets to create one data set
## ----------
X_data <- rbind(X_train, X_test)

## ----------
## 2.  Extract only the measurements on the mean and standard deviation for each
## measurement
## ----------

# Need to decide which columns correspond to mean & standard deviation
# The features data.frame contains column names
# According to features_info.txt
#     mean() : Mean value
#     std() : Standard deviation
#
# Note that there are some other references to "mean" such as meanFreq() and
# also those used on the angle() varaible (gravityMean, etc).  I will assume
# that these columns are not required (from what I have read on the forum this
# is up to individual discretion).

# Create a vector which contains the position of those elements with
# mean()" or std() in them
keep_columns <- grep("mean\\(\\)|std\\(\\)", features[,2])
# use this to extract the relevant columns from the test & train data sets
X_data2 <- X_data[,keep_columns]

## ----------
## 3.  Use descriptive activity names to name the activities in the data set
## ----------

# Raw activities are stored in the y_train & t_test data sets
all_activity <- rbind(y_train, y_test)
# The activity_lables.txt file contains descriptive names which can be used
# to re-label the raw data
all_activity2 <- data.frame(sapply(all_activity, function(X) { activity_labels[X,2]}))
names(all_activity2) <- "activity"

## ---------- 
## 4.  Appropriately labels the data set with descriptive variable names
## ----------

# Variable names are described in the "features" file
x <- features$V2[keep_columns]
# Chose to do a small amount of cleaning on these names before assigning them
#   The "()" don't really add much value so take those out
#   Also the "-"
x <- sub("\\(\\)", "", x)
x <- gsub("-", "", x)
# Now we can label all the variables in X_data
names(X_data2) <- x

## ----------
## Combine all data into 1 x dataframe (prior to step 5)
## ----------

# Need to add the all_activity2 data to the main dataset
X_data2 <- cbind(all_activity2, X_data2)

# Need to add the subject data to the main dataset
all_subject <- rbind(subject_train, subject_test)
names(all_subject) <- "subject"
X_data2 <- cbind(all_subject, X_data2) 

# Now we have the full data set (X_data2)


## ----------
## 5.  From the data set, create a second independent tidy data set
## With the average of each variable for each activity & each subject
## ----------

x <- arrange(X_data2, subject, activity)
tidy_data <- summarize_each(group_by(x, subject, activity), funs(mean))

write.table(tidy_data, file = "tidy_data.txt", row.name = FALSE)

# Note on tidy_data
# There are 30 x subjects, and 6 x activities (repeated for each subject)
# We therefore have 180 rows of data
#
# The column names for the individual variables are already long
# I decided that renaming them further by adding something like "avg"
# didn't really help make the data set any more usable, so left them as
# they were.


