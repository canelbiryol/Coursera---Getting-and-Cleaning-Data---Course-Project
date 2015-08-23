main_directory = "UCI HAR Dataset"

# For Steps 2,3,4 Read Training and Test data and apply transformations
read_dataset <- function(data_type) {
  
  ## Read Subject Data (Subject)
  subject  <- read.table(paste(main_directory, data_type, paste("subject_",data_type,".txt",sep=""),sep="/"))
  # Name column as 'subject_id'
  names(subject) <- c('subject_id')
  
  
  ## Read Label Data (Y)
  y <- read.table(paste(main_directory, data_type, paste("y_",data_type,".txt",sep=""),sep="/"))
  
  # Step 3.
  # Uses descriptive activity names to name the activities in the data set
  # Read Activities for Y Data
  activities <- read.table(paste(main_directory,"activity_labels.txt",sep="/"))
  
  # Replace activity ids with descriptive activity names
  y[, 1] <- activities[y[, 1], 2]
  # Name column as 'activity'
  names(y) <- c('activity')
  
  
  # Read Set Data (X)
  x <- read.table(paste(main_directory, data_type, paste("X_",data_type,".txt",sep=""),sep="/"))
  
  # Read Features for X Data
  features <- read.table(paste(main_directory,"features.txt",sep="/"))
  # Step 2.
  # Extracts only the measurements on the mean and standard deviation for each measurement. 
  # Select Mean and Std cols
  selected_cols <- grep("-(mean|std)\\(\\)", features[, 2])
  
  # Subset x with selected cols
  x <- x[, selected_cols]
  
  # Step 4.
  # Appropriately labels the data set with descriptive variable names. 
  # Name columns in X with selected feature names
  names(x) <- features[selected_cols, 2]
  
  # Bind subject, labels and set data into a single dataframe and return
  cbind(subject,y,x)
}

# Steps 2,3,4
test_data <- read_dataset('test')
train_data <- read_dataset('train')

# Step 1 
# Merges the training and the test sets to create one data set.
merged_data <- rbind(train_data, test_data)

# Step 5
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# !! Ignores NA's while calculating mean
average_data <- aggregate(merged_data[, 3:68], list(subject_id=merged_data$subject_id,activity=merged_data$activity), mean, na.rm=TRUE)
write.table(average_data, "average_data.txt", row.name=FALSE)

