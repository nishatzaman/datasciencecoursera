# Code Book

The run_analysis.R script retrieves and cleans the data from the dataset that is provided on the course project site.

The following steps were taken:

**1. Download the dataset**

The dataset was downloaded from the course project site, with the files in the 'UCI HAR Dataset' folder.

**2. Read the data into data tables.**

The following tables were created in the script:

*features (from features.txt):* Has 561 rows and 2 columns.
Contains a list of all the features that were derived from the measurements captured by the accelerometer and gyroscope (i.e. 3-axial linear acceleration and 3-axial angular velocity).

*x_test (from test/X_test.txt):* Has 2947 rows and 561 columns.
Contains the measurements for the test set.

*y_test (from test/y_test.txt):* Has 2947 rows and 1 column.
Contains the corresponding activity labels for the measurements in the test set.

*x_train (from test/X_train.txt):* Has 7352 rows and 561 columns.
Contains the measurements for the training set.

*y_train (from test/y_train.txt):* 7352 rows and 1 column.
Contains the corresponding activity labels for the measurements in the training set.

*subject_test (from test/subject_test.txt):* Has 2947 rows and 1 column.
Contains information about the subjects who were in the test set. Each subject is represented by an identifier between 1-30.

*subject_train (test/subject_train.txt):* Has 7352 rows and 1 column.
Contains information about the subjects who were in the training set. Each subject is represented by an identifier between 1-30.

*activities (activity_labels.txt):* Has 6 rows and 2 columns.
This data set contains a list of all the activities performed by the participants and their corresponding labels.

**3. Merge the training and test sets to create a single data set.**

*x_set*: Has 10299 rows and 561 columns. Was created through using the **rbind()** function on 'x_train' and 'x_test'.

*y_set*: Has 10299 rows and 1 column. Was created through using the **rbind()** function on 'y_train' and 'y_test'.

*subjects*: Has 10299 rows and 1 column. Was created through using the **rbind()** function on 'subject_train' and 'subject_test'.

*merged_data*: Has 10299 rows and 563 columns. Was created through merging 'x_set', 'y_set' and 'subjects' using the **cbind()** function.

**4. Extract only the measurements on the mean and standard deviation for each measurement.**

*new_data:* Has 10299 rows and 88 columns. This data set was created through selecting the 'subject' and 'activity_label' columns as well as the columns that contain the string *"mean"* or *"std"*.

**5. Use descriptive activity names to name the activities in the data set.**

The numbers in the 'activity_label' column were replaced with their corresponding descriptions. This was done through performing an inner join on the 'new_data' and 'activities' data tables.

**6. Appropriately label the data set with descriptive variable names.**

The following changes were made to the following strings present in the column names:

    - All "BodyBody" replaced with "Body"
    - All "Freq" replaced with "Frequency"
    - All "Gyro" replaced with "Gyroscope"
    - All "Acc" replaced with "Accelerometer"
    - All "angle" replaced with "Angle"
    - All "std" replaced with "STDEV"
    - All "mean" replaced with "Mean"
    - "subject" replaced with "Subject"
    - "activity" replaced with "Activity"
    - All "t"s at the start of the column name replaced with "Time"
    - All "f"s at the start of the column name replaced with "Frequency"
    - All "mag" replaced with "Magnitude"
    - All "tBody" replaced with "TimeBody"
    - All "gravity" replaced with "Gravity"

**7. Create a second, independent tidy data set with the average of each variable for each activity and each subject.**

*tidy_data*: This data set was created through summarising 'joined_data' through taking the mean of each column after grouping the data by subject and activity. The table 'tidy_data' was then exported into the file 'TidyData.txt'.
