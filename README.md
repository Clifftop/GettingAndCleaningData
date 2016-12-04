# Peer-graded Assignment: Getting and Cleaning Data Course Project

This README file covers the following topics :

1.  Obtaining the original data set
2.  Using the `run_analysis.R` code
3.  Description of the `run_analysis.R` code

## Obtaining the original data set

The data set can be obtained from the following location:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This data can be downloaded from a browser and saved to the local computer

The file can be unzipped, which will create a directory structure with a
subdirectory "UCI HAR Dataset"

## Using the `run_analysis.R` code

The "UCI HAR Dataset"" directory should be copied or moved
to the folder containing `run_analysis.R`

The `run_analysis.R` file can be executed within R Studio with the command:

```{r}
> source( "run_analysis.R")
```

The code will generate an output file `tidy_data.txt`

The contents of the file `tidy_data.txt` are explained in the *Codebook* contained
in this github directory.

## Description of the `run_analysis.R` file

### Initial Stage : Read in all the relevant data files

The "test" directory (subidrectory of UCI HAR Dataset) contains

* `X_test.txt` The measurement data
* `y_test.txt` The activity (from 1 to 6)
* `subject_test.txt`The subject identifier (from 1 to 30)

The directory "Inertial Signals" can be ignored as the assignment asks only for
mean() and std() data.

Similarly the "train" directory (subdirectory of UCI HAR Dataset) contains

* `X_train.txt` The measurement data
* `y_train.txt` The activity (from 1 to 6)
* `subject_train.txt` The subject identifier (from 1 to 30)

Again, the "Inertial Signals" directory can be ignored.

In the UCI HAR Dataset directory itself, two files are used

* `activity_labels.txt`

This file provides a table that can be used to translate the information in
y_test.x and y_train.x (the values 1 through 6) into meaningful text

* `features.txt`

This provides information of all the column data in the files "X_test.x"
and "y_test.x"

### Step 1 : Merge the training and the test sets to create one data set

Use rbind to add the "X_test" data below the "X_train" data.
(The required order is not specified).

### Step 2 : Extract only the measurements on the mean and standard deviation
for each measurement

Reviewing the features_info.txt file, we see that:

* mean() : Mean value
* std() : Standard deviation

There are additional vectors mentioned (meanFreq, gravityMean, tBodyAccMean).
It is not clear whether these need to be included.

The project forum provides a link to a post by David Hood which indicates that the decision is up to the
student.  I chose not to include them.

### Step 3 : Use descriptive activity names to name the activities in the data set

Here we first add the "y_test" data below the "y_train" data.
Then using the data in "activity_labels.txt", we substitute meaningful names
for the numeric values.

Note that the resulting dataframe (all_activity2) 
contains this data as factors.

### Step 4 : Appropriately labels the data set with descriptive variable names

The variable names for each column of X_test and X_train are contained in the
features.txt file.

Some manipulation is performed on the raw variable names:
* The "()" are removed.  They don't appear to add value
* Similarly, the "-" are removed.  They also don't appear to add value
The resulting variable names are a little easier to work with

### Combine all data into 1 x dataframe
At this stage of the process we have:

* X_data2 - a dataframe containing all the measurement data
* all_activity2 - a dataframe containing all the activities

We also need to add the subject data from the files subject_train.txt and
subject_test.txt.

The above 3 data elements are combinded into a single data frame
X_data2, which has :
* 10299 observations
* 68 variables
First columns is : "subject"
Second column is : "activity"
Remaining columns are the "mean" and "std" values

### Step 5 : Create a second independent tidy data set with the average of each variable for each activity and each subject

This is done in two steps.
First step : arrange the data in order by "subject" first, then by "activity"

Second step : group to data by subject and activity, and calculate the mean for 
that grouping.

As there are 30 x subjects and 6 x activities, we end up with 180 groups
(i.e. 180 rows of data)

This grouping and data is stored in a dataframe "tidy_data", which is written
to the file `tidy_data.txt` (submitted for this assignment)

The contents of tidy_data are described in the file Codebook.md














