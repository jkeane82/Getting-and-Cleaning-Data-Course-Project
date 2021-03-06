Getting and Cleaning Data Course Project
=========================================================================================
James M. Keane
Coursera
Data Science Specialization
Johns Hopkins University
Getting and Cleaning Data
=========================================================================================

The following steps were used to creat tidy data sets from data collected from the accelerometersfrom the Samsung Galaxy S smartphone.

1.  Merges the training and the test sets to create one data set.                                          
2.  Extracts only the measurements on the mean and standard deviation for each measurement.
3.  Uses descriptive activity names to name the activities in the data set.
4.  Appropriately label the data set with descriptive variable names. 
5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Original files use analysis includes the following which contain the descriptions of varaibles:
========================================================================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'subject_train.txt': List of subjects for each test record

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'subject_test.txt': List of subjects for each test record

The tidy data sets produced from the files that were included in the original data sets:
========================================================================================

- 'test.train.activity_Mean.Summary.Data.txt'

The following describe the steps and transformations made to create the tidy data files.
All files must be set in the users working directory for the run_script to retrieve data.
============================================ 1 =============================================

1. Import feature file to get variable names.

2. Import test files and assign variable names.
	- X_test.txt -> data
	- y_test.txt -> labels for each record
	- subject_test.txt -> list of subjects for test data

3. Import train files and assign variable names.
	- X_train.txt -> data
	- y_train.txt -> labels for each record
	- subject_train.txt -> list of subjects for train data

4. Merge imported and variable named test and train data sets.

============================================ 2 =============================================

1. Extract mean and standard deviation varaibles and create new data set with labels and activities.
	- This was done using the grepl function where it only included variables with "mean()" and "std()".

============================================ 3 =============================================

1. Import activity lable text file and rename headers.
	- 'activity_labels.txt'

2. Rename variables in new data set containing activities.

3. Match the labels (integers) from data set produce in (2) with actual activity name so that it's understood what activity was performed for each record.

4. Within newly matched activities, remove any characters within vector.

============================================ 4 =============================================

1. Saved column names in new vector.

2. Rename variables in new vector from data set so that they are more descriptive.
	- If variable started with the letter "t", replaced with "Time".
	- If variable started with the letter "f", replaced with "FastFourierTransform".
	- If variable contained "Acc", replaced with "Acceleration".
	- If variable contained "-mean()", replaced with "Mean".
	- If variable contained "-std()", replaced with "StanDev".
	- If variable contained "-", replaced with "", no value.

3. Saved renamed variable names to data set.

============================================ 5 =============================================

1. Saved above tidy data set into a table (non data frame).

2. Created new table where data was grouped by activities (WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, etc.) and by subjects.

3. Summary of grouped table was exectured where the mean value was calculated for each variable based on the created groups.

4. Grouped table with mean values for each variable based on groups (activities, subjects) is exported.
	- 'test.train.activity_Mean.Summary.Data.txt'