# Code Book

This document describes the code inside `run_analysis.R`.

The code is splitted (by comments) in some sections:

* Source Materials
* Variables used in this script
* Transformation Performed

## Source materials

The data used for this script can be downloaded at this URL:

* https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This data come from an experiment with a group of 30 volunteers. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope the personnel conducting the experiment was able to record 3-axial linear acceleration and 3-axial angular velocity of the test subjects during the experiment.

The full description can be obtained at this site:

 * http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

For this script we used the following files within the .zip folder downloaded:

* 'features.txt'            : List of all features
* 'activity_labels.txt'     : Links the class labels with their activity name (not loaded, onlu consulted for the script, consisting of only 6 variables -1 = WALKING, 2 = WALKING_UPSTAIRS, 3 = WALKING_DOWNSTAIRS, 4 = SITTING, 5 = STANDING, 6 = LAYING-)
* 'train/X_train.txt'       : Training set
* 'train/y_train.txt'       : Training labels
* 'train/subject_train.txt' : Subject ID of training set
* 'test/X_test.txt'         : Test set
* 'test/y_test.txt'         : Test labels
* 'test/subject_test.txt'   : Subject ID of test set

## Variables used in this script(ordered by apparition):

* TrainSet      : Stored data from X_train.txt
* TrainLabels   : Stored data from y_train.txt
* TrainSubject  : Stored data from subject_train.txt
* TestSet       : Stored data from X_test.txt
* TestLabels    : Stored data from y_test.txt
* TestSubject   : Stored data from subject_test.txt
* Features      : Stored data from features.txt
* Test          : Merged Test data sets
* Train         : Merged Train data sets
* TestTrain     : Complete set of all data
* mean          : Vector of a pattern search for the word Mean in the names of the columns of TestTrain ('[Mm][Ee][Aa][Nn]')
* stdev         : Vector of a pattern search for the word Std in the names of the columns of TestTrain ('[Ss][Tt][Dd]')
* meanst        : Vector of strings with the column names of TestTrain with the word Mean, Std and the first column ('Activity')
* dupl          : Vector of duplicated column names
* MEAN          : Vector of a pattern search for the word Mean in the names of the dupl vector ('[Mm][Ee][Aa][Nn]')
* STDEV         : Vector of a pattern search for the word Std in the names of the dupl vector ('[Ss][Tt][Dd]')
* TestTrain2    : Set of all data minus from the columns containing the word Mean, Std and the first column
* Final         : Final dataset, with the average of all columns, grouped by Activity

## Transformation Performed

0) Downloading the dataset and porting of the data in the TrainSet, TrainLabels, TestSet, TestLabels, and Features variables, using 
* read.csv()
1) Merging TestSubject and TestLabels with TestSet. Merging TrainSubject and TrainLabels with TrainSet, using 
* cbind()
2) Merging Test with Train, using 
* rbind()
3) Inverting the Feature data set, subsetting the second row, transforming it into character and assigning it to the same variable name, using 
* as.character(), t()
4) Assigning the name 'Subject' to the first column of TestTrain (the former TrainSubject and TestSubject), assigning the name 'Activity' to the second column of TestTrain (the former TrainLabels and TestLabels) and assigning the strings inside Features to the other columns, using 
* [], length(), names()
5) Transforming the first and second column of TestTrain in factors and assigning to the levels the variables inside the activity_labels.txt file, using 
* [], as.factor(), c(), levels()
6) Creating mean and stdev with the column names with the word Mean and Std, merging and adding the name of the fist and second columns thus creating meanst, using 
* c(), colnames(), grep()
7) Creating dupl, with the duplivate names columns and checking if the vector contains the word mean and std (MEAN and STDEV variables), checked the length for being sure of the absence of any column of interest( # commented out for making the script more readable), using 
* colnames(), duplicated(), grep(), length()
8) Creation of TestTrain2 by the removal of the duplicated columns and selection of the columns containing the word Mean, Std and the first and second columnn from TestTable, using 
* [], colnames(), duplicated(), select()
9) Creation of Final, grouping the data of TestTrain2 by subject and activity and summarising of the mean of all its columns, using 
* %>%, group_by(), mean.default(), summarise()


## Writing final data to .txt 

At the end of the script a txt file is created, named 'CleanData.txt'
