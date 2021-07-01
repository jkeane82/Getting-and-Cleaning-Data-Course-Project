#############################################################################################################################
# Description: Import and clean create tidy data sets from data collected from the accelerometers from the Samsung Galaxy   # 
#               S smartphone. The following steps will executed in this file:                                               #
#                                                                                                                           #
#               1.  Merges the training and the test sets to create one data set.                                           #
#               2.  Extracts only the measurements on the mean and standard deviation for each measurement.                 #
#               3.  Uses descriptive activity names to name the activities in the data set.                                 #  
#               4.  Appropriately label the data set with descriptive variable names.                                       #
#               5.  From the data set in step 4, creates a second, independent tidy data set with the average of each       #
#                   variable for each activity and each subject.                                                            #
#                                                                                                                           #
# Date: 2021.06.28                                                                                                          #
# Developer: James Keane                                                                                                    #   
# Course: Getting and Cleaning Data                                                                                         #
# Assignment: Course Project                                                                                                #
#############################################################################################################################

library(dplyr)
library(tibble)
library(readr)

# Save all necessary files listed in README.md and CODEBOOK.md file in the working directory.
workingDIR <- getwd()

################################################################################ 1 ################################################################################

# Import feature file to get variable names
features <- read_table2(paste(workingDir,"features.txt", sep = ""), col_names = FALSE)
featureNames <- features$X2

# Import test files
x_test <- read_table2(paste(workingDir, "X_test.txt", sep = ""), col_names = FALSE)
colnames(x_test) <- featureNames
y_test <- read_table2(paste(workingDir, "y_test.txt", sep = ""), col_names = FALSE)
colnames(y_test) <- "labels"

# Import test subject file
test_subjects <- read_table2(paste(workingDir, "subject_test.txt", sep = ""), col_names = FALSE)
colnames(test_subjects) <- "subjects"

# Merge data
testData <- cbind(y_test, test_subjects, x_test)

# Import train files
x_train <- read_table2(paste(workingDir, "X_train.txt", sep = ""), col_names = FALSE)
colnames(x_train) <- featureNames
y_train <- read_table2(paste(workingDir, "y_train.txt", sep = ""), col_names = FALSE)
colnames(y_train) <- "labels"

# Import train subject file
train_subjects <- read_table2(paste(workingDir, "subject_train.txt", sep = ""), col_names = FALSE)
colnames(train_subjects) <- "subjects"

trainData <- cbind(y_train, train_subjects, x_train)

# Merge test and train data sets
test_train_Date <- rbind(testData, trainData)

################################################################################ 2 ################################################################################

# Extract mean and standard deviation features
tt_mean_std_Data <- cbind("activities" = test_train_Date$labels, 
                          "subject" = test_train_Date$subject, 
                          test_train_Date[,grepl("mean\\(\\)|std\\(\\)", colnames(test_train_Date)) == TRUE])

################################################################################ 3 ################################################################################

# Import activity label text file and rename headers
activities <- read_table2(paste(workingDir, "activity_labels.txt", sep = ""), col_names = FALSE)
colnames(activities) <- c("labels", "activities")

# Match labels in test/train data with activity names and remove characters from activity names
tt_mean_std_Data$activities <- activities$activities[match(tt_mean_std_Data$activities, activities$labels)]
tt_mean_std_Data$activities <- gsub("_", " ", tt_mean_std_Data$activities)

################################################################################ 4 ################################################################################

# Rename labels so that they are more descriptive
reNameCols <-colnames(tt_mean_std_Data)
reNameCols <- gsub("^t", "Time", reNameCols)
reNameCols <- gsub("^f", "FastFourierTransform", reNameCols)
reNameCols <- gsub("Acc", "Acceleration", reNameCols)
reNameCols <- gsub("-mean\\(\\)", "Mean", reNameCols)
reNameCols <- gsub("-std\\(\\)", "StanDev", reNameCols)
reNameCols <- gsub("-", "", reNameCols)
colnames(tt_mean_std_Data) <- reNameCols

################################################################################ 5 ################################################################################

# Save data frame in table format
finalData <- tibble(tt_mean_std_Data)

# Calculate the mean for each activity and for each subject
average_grouped_Data <- finalData %>% 
    group_by(activities, subject) %>%
    summarize_all(mean)

write.table(average_grouped_Data, paste0(workingDir, "test.train.activity_Mean.Summary.Data.txt", collapse = ""), row.names = FALSE)







