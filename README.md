# "Getting & Cleaning Data" course project
  


## Overview

The script *run_analysis.R* downloads and unzips to a data folder in the working directory a collection of data from [this](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ) address. The original data is split into two subsets--a training set and a test set--each of which is itself distributed across three files. These files respectively provide, for each observation: (i) a subject identifier, (ii) an activity code and (iii) a vector of features. For each of the two subsets, the script first merges the information contained in (i)-(iii), and clarifies the content of the resulting dataset, by descriptively labeling the columns and replacing the activity codes by their corresponding descriptive label. The subsets are then merged into one large data set. This dataset is then pruned to retain only the feature columns pertaining to standard deviation and mean. Finally, the script reshapes the data to display the average of each variable for each activity and each subject. The reshaped data is then written to a .txt file.  

The markdown file *CodeBook.md* provides the details of the variables, data and transformations involved in cleaning the data. 

## Libraries

The script requires the prior installation of packages *R.utils* and *reshape2*.
