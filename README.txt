=============================================================
Getting and Cleaning Data Course Project
========================================================================================
James M. Keane
Coursera
Data Science Specialization
Johns Hopkins University
Getting and Cleaning Data
========================================================================================

One of the most exciting areas in all of data science right now is wearable computing - see for example this article. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users.  The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The purpose of this project it to use the data above and run through a series of steps to combine and clean data into a format
in which is easy to understand and use for analysis.

For each record it is provided:
========================================================================================

- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 

The dataset used in analysis includes the following files:
========================================================================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The tidy data sets produced from the files that were included in the original data sets:
========================================================================================

- 'test.train.activity_Mean.Summary.Data_2021.06.29.csv'
- 'test.train_Mean.STD.Data_2021.06.29.csv'

Analysis Files:
========================================================================================

- 'run_analysis.R'

Notes: 
======
- Measurements used from original data are ones were data calculated the mean and standard deviation for each measurement. 
- Summary file contains the average of each variable for each activity and each subject (test and train).