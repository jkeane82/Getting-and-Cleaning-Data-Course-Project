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

################################################################################ 1 ################################################################################

# Import feature file to get variable names
features <- read_table2("C:/Users/james.keane/Documents/James Keane/Education/Coursera/Data Science Specialization/Getting and Cleaning Data/Course Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt", col_names = FALSE)
featureNames <- features$X2

# Import test files
testDir <- "C:/Users/james.keane/Documents/James Keane/Education/Coursera/Data Science Specialization/Getting and Cleaning Data/Course Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/"
x_test <- read_table2(paste(testDir, "X_test.txt", sep = ""), col_names = FALSE)
colnames(x_test) <- featureNames
y_test <- read_table2(paste(testDir, "y_test.txt", sep = ""), col_names = FALSE)
colnames(y_test) <- "labels"

testData <- cbind(y_test, "subject" = rep("TEST", nrow(x_test)), x_test)

# Import train files
trainDir <- "C:/Users/james.keane/Documents/James Keane/Education/Coursera/Data Science Specialization/Getting and Cleaning Data/Course Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/"
x_train <- read_table2(paste(trainDir, "X_train.txt", sep = ""), col_names = FALSE)
colnames(x_train) <- featureNames
y_train <- read_table2(paste(trainDir, "y_train.txt", sep = ""), col_names = FALSE)
colnames(y_train) <- "labels"

trainData <- cbind(y_train, "subject" = rep("TRAIN", nrow(x_train)), x_train)

# Merge test and train data sets
test_train_Date <- rbind(testData, trainData)

################################################################################ 2 ################################################################################

# Extract mean and standard deviation features
tt_mean_std_Data <- cbind("activities" = test_train_Date$labels, 
                          "subject" = test_train_Date$subject, 
                          test_train_Date[,grepl("mean\\(\\)|std\\(\\)", colnames(test_train_Date)) == TRUE])

################################################################################ 3 ################################################################################

# Import activity lable text file and rename headers
activities <- read_table2("C:/Users/james.keane/Documents/James Keane/Education/Coursera/Data Science Specialization/Getting and Cleaning Data/Course Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", col_names = FALSE)
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

write.csv(tt_mean_std_Data, paste0("C:/Users/james.keane/Documents/James Keane/Education/Coursera/Data Science Specialization/Getting and Cleaning Data/Course Project/test.train_Mean.STD.Data_", 
                                   format(Sys.Date(), "%Y.%m.%d"), ".csv", collapse = ""))


################################################################################ 5 ################################################################################

# Save data frame in table format
finalData <- tibble(tt_mean_std_Data)

# Calculate the mean for each activity and for each subject
average_grouped_Data <- finalData %>% 
    group_by(activities, subject) %>%
    summarize_all(mean)

write.csv(average_grouped_Data, paste0("C:/Users/james.keane/Documents/James Keane/Education/Coursera/Data Science Specialization/Getting and Cleaning Data/Course Project/test.train.activity_Mean.Summary.Data_", 
                                   format(Sys.Date(), "%Y.%m.%d"), ".csv", collapse = ""))







