This documents describes the operations and code run with run_analyisis.R


# run_analyisis.R
This script performs the operations described in 5 Steps in project description.

* The script reads training and test data and applies Steps 2,3,4 on each dataset with read_dataset() function. Description of read_dataset() funciton is below.
* After reading test and training data, we merge these two datasets with rbind function as described Step 1.
* Finally aggregate values by activity and subject, calculate means and output it to average_data.txt as described in Step 5.

# read_dataset()
This function reads training and test datasets and performs Step 2,3,4 operations.

* Read subject data and name header column as 'subject_id'
* Read Label Data (y) and then change activity ids with activity names described in 'activity_labels.txt', rename column to 'activity'. (Step 3)
* Read Set Data (X), select columns related to mean and std, and rename column names with descriptive column names in 'feature.txt'. (Step 2 & Step 4)
* Merge subject data, y data and x data into a single dataframe using cbind and return.

# Variables
* main_directory: 'UCI HAR DATASET' - Main directory location for datafiles
* test_data: Output dataframe for test data after reading with read_dataset()
* train_data: Output dataframe for training data after reading with read_dataset()
* merged_data: Combined dataset of train and test data
* average_data: Result of average means of merged_data by subject and activity.

