# Code Book

## Script details

1. Load the libraries 
- Create a data folder in the working directory 
- Download and unzip the data files to the data folder 
- Read the following files into data frames: 
 + `features.txt`, which contains feature names
 + `activity_labels.txt`, which contains the mappings from activity codes to descriptive activity names
 + `X_train.txt` and `X_test.txt`, which contain the vectors of features 
 + `y_train.txt` and `y_test.txt`, which contain the activity codes 
 + `subject_train.txt` and `subject_test.txt`, which contain the subject identifiers  
- Give meaningful labels to the columns of the feature vector data frames `features.test` and `features.train` using the feature name data frame `feature.names`
- Give meaningful labels to the columns of the subject and activity data frames
- Bind together the respective subject identifier, activity code and feature vector data frames to create the test and training data frames, `raw.dataset.test` and `raw.dataset.train`
- Bind together `raw.dataset.test` and `raw.dataset.train` to make one large data frame `raw.dataset`
- Retain in a slimmed-down data frame `slim.raw.dataset` only those feature columns pertaining to standard deviation and mean
- Use the descriptive activity labels retrieved from the ``activity_labels.txt`` file to replace the activity codes in the relevant column of `slim.raw.dataset` 
- Create a tidy data set `tidy.dataset`  with the average of each variable for each activity and each subject, by melting `slim.raw.dataset` and recasting it as required
- Write `tidy.dataset` to `tidy_dataset.txt` 

## Data 

The original `README.txt` file (in the `UCI HAR Dataset` folder, available in the working directory after running the script.) provided the following information on the experimental procedure

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 


## Variables


The variables in the .txt file output include:

- *subject*: subject identifier, integer variable with a range of [1,30]
- *activity*: activity label, factor variable drawn from {LAYING, SITTING, STANDING, WALKING, WALKING\_DOWNSTAIRS, WALKING_UPSTAIRS}    

The remaining variables are numeric variables corresponding to **mean values**, for each subject/activity combination, of either the means (indicated by the suffix *-mean()*) or standard deviations (indicated by the suffix *-std()*) of various quantities derived from the accelerometer and gyroscope readings. The *-X*, *-Y* and *-Z* suffixes, when they occur, indicate a measurement along a particular gyroscope direction axis. The relevant quantities are the following:
              
- *tBodyAcc*
- *tGravityAcc*
- *tBodyAccJerk*
- *tBodyGyro*
- *tBodyGyroJerk*
- *tBodyAccMag*
- *tGravityAccMag*
- *tBodyAccJerkMag*
- *tBodyGyroMag*
- *tBodyGyroJerkMag*
- *fBodyAcc-XYZ*
- *fBodyAccJerk-XYZ*
- *fBodyGyro-XYZ*
- *fBodyAccMag*
- *fBodyAccJerkMag*
- *fBodyGyroMag*
- *fBodyGyroJerkMag*

For a more detailed description of these quantities and their measurement, see the `features_info.txt` files in the aforementioned `UCI HAR Dataset` folder.