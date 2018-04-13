#Libaries
library(dplyr)
#Loading Data
TrainSet <- read.table('X_train.txt')
TrainLabels <- read.table('y_train.txt')
TestSet <- read.table('X_test.txt')
TestLabels <- read.table('y_test.txt')
Features <- read.table('features.txt')

#-------------------------------------------------------------------------------

#TestTrain data.frame creation
#merging set and labels

Test <- cbind(TestLabels, TestSet)
Train <- cbind(TrainLabels, TrainSet)

#merging Test and Train (Merges the training and the test sets to create one data set)

TestTrain <- rbind(Test, Train)

#-------------------------------------------------------------------------------

#Tidying up TestTrain (Appropriately labels the data set with descriptive variable names)

Features <- t(Features)
Features <- as.character(Features[2,])
names(TestTrain)[1] <- 'Activity'
names(TestTrain)[2:length(names(TestTrain))] <- Features

#Tidying up Activities (Uses descriptive activity names to name the activities in the data set)

# str(TestTrain) check for the following funcion
TestTrain[,1] <- as.factor(TestTrain[,1])
levels(TestTrain[,1]) <- c('1' = 'WALKING', '2' = 'WALKING_UPSTAIRS', '3' = 'WALKING_DOWNSTAIRS',
                           '4' = 'SITTING', '5' = 'STANDING', '6' = 'LAYING')
# str(TestTrain) check for the previous funcion

#-------------------------------------------------------------------------------

#Selecting only mean and stdev columns

#creating a list of column names with 'Mean' or 'Std' inside the string 

mean <- grep( '[Mm][Ee][Aa][Nn]' , colnames(TestTrain), value = T)
stdev <- grep('[Ss][Tt][Dd]', colnames(TestTrain), value = T)
meanst <- c('Activity', mean, stdev)

#duplicate column names issue, checking if the columns have 'mean' or 'std' inside

dupl <- colnames(TestTrain)[duplicated(colnames(TestTrain))]
MEAN <- grep( '[Mm][Ee][Aa][Nn]' , dupl, value = T)
STDEV <- grep('[Ss][Tt][Dd]', dupl, value = T)
# length(MEAN) check for the previous funcion
# length(STDEV) check for the previous funcion

#as no duplicate columns is of interest proceding to removing them from the data frame

TestTrain2 <- TestTrain[,!(duplicated(colnames(TestTrain)))]
# colnames(TestTrain2)[duplicated(colnames(TestTrain2))] check for the previous funcion

#Selecting only mean and stdev columns(Extracts only the measurements on the mean and standard deviation for each measurement)

TestTrain2 <- select(TestTrain2, meanst)

#-------------------------------------------------------------------------------

#Creating the New Data Set (From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.)

Final <- TestTrain2 %>% group_by(Activity) %>%
        summarise_all(mean.default)

#-------------------------------------------------------------------------------

#Writing CSV file
write.csv(Final, file = 'CleanData.csv')





























