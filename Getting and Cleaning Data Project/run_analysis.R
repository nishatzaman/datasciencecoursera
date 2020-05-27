library(dplyr)

#Read the data into data tables
features <- read.table("./UCI HAR Dataset/features.txt", col.names = c("num", "measurements"))

x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features$measurements)

y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "activity_label")

x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features$measurements)

y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "activity_label")

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

activities <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("key", "activity"))

#Step 1: Merge the training and test sets to create one data set
x_set <- rbind(x_train, x_test)

y_set <- rbind(y_train, y_test)

subjects <- rbind(subject_train, subject_test)

merged_data <- cbind(subjects, x_set, y_set)

#Step 2: Extracts only the measurements on the mean and standard deviation for each measurement
new_data <- merged_data %>% select(subject, activity_label, matches("mean|std"))

#Step 3: Uses descriptive activity names to name activities in the data set
joined_data <- inner_join(new_data, activities, by = c('activity_label' = 'key')) %>% select(-activity_label)

#Step 4: Appropriately labels the data set with descriptive variable names
names(joined_data) <- gsub("BodyBody", "Body", names(joined_data))

names(joined_data) <- gsub("Freq", "Frequency", names(joined_data))

names(joined_data) <- gsub("Gyro", "Gyroscope", names(joined_data))

names(joined_data) <- gsub("Acc", "Accelerometer", names(joined_data))

names(joined_data) <- gsub("angle", "Angle", names(joined_data))

names(joined_data) <- gsub("std", "STDEV", names(joined_data))

names(joined_data) <- gsub("mean", "Mean", names(joined_data))

names(joined_data) <- gsub("subject", "Subject", names(joined_data))

names(joined_data) <- gsub("activity", "Activity", names(joined_data))

names(joined_data) <- gsub("^t", "Time", names(joined_data))

names(joined_data) <- gsub("^f", "Frequency", names(joined_data))

names(joined_data) <- gsub("Mag", "Magnitude", names(joined_data))

names(joined_data) <- gsub("tBody", "TimeBody", names(joined_data))

names(joined_data) <- gsub("gravity", "Gravity", names(joined_data))

#Step 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_data <- joined_data %>% group_by(Subject, Activity) %>% summarise_all(funs(mean))

write.table(tidy_data, "TidyData.txt", row.name=FALSE)
