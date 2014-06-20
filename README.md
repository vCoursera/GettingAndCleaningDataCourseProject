Getting And Cleaning Data Course Project
===================================

## Problem Statement

Create one R script called run_analysis.R that does the following. 
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


---

## Source Files

run_analysis.R


---

## Execution Instructions

The source file has one method run_analysis() , the execution of which gives the desired tidy data set as output. The program assumes that the Samsung Smartphone data is in the working directory from which the program will be executed.


---

## Execution Phases

* Consolidate subject, Activity and Training Statistics Data               
* Extract required columns (mean and std cols) and add correct labels      
* Substitute Activity Id with Activity Name                                
* Consolidate subject, Activity and Test Statistics Data                   
* Extract required columns (mean and std cols) and add correct labels      
* Substitute Activity Id with Activity Name                                
* Consolidate subject, Activity and Training Statistics Data               
* Merge the Test and Training Data and print the tidy data to console      

## Execution Phases Description

The program starts execution by loading the files corresponding to the training data , namely subject_train.txt , y_train.txt and X_train.txt. Once the subject and the activity data(y_train) is loaded the columns are named so that they are logicaly relevant to the cause. The data frames w.r.t. these files are combined using the cbind function to ensure columnwise merge.

The functions/ features are fetched into a separate data frame that has 2 columns , the column id and the name and are mean and standard deviation related features. 

The Feature data is used over the Raw Training data to generate the tidy data corresponding to the functions / features related to mean and standard deviation measurements. 

The raw data is then decoded for activity id and the same are replaced with corresponding activity lables. The data is then added as a column to the tidy data.

The subject data too is added as a column to the tidy data for training and the process to extract , transform and load data for training data into a tidy set as a data frame is complete.


Similar process is followed for the test data.

The two tidy data sets are then merged to form a unified tidy set.

This dataset is then processed using melt to retrieve data corresponding to the 2 variables of SubjectId and Activity.

Finally, the result is cast to a dataset that depicts the mean and standard deviation data for each Activity Label per Subject.


This dataset satisfies all the components of the problem statement.

The program prints the resultant tidy data set on console as it finishes the execution.
