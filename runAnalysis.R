#12 Sep 2015
#Arun Trivedi
#c:\users\username\datasciencecoursera\datacleanup\run_analysis.R

# "UCI HAR Dataset.zip" is the file downloaded from internet contains
# Training and Testing data of measurements carried out on a set of 30 
# subjects using Smartphones. The information is collected in text/csv #files.  
# Create below mentioned tidy data sets for future analysis:
# (1) single train, test dataset with descriptive variable names
# (2) avg. of each variable & activity  per subject

# download raw data file from internet
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "runAnalysis.zip")
dateDownloaded <- date()
unzip ("runAnlysis.zip") # all unzip files are .txt files

# load necessary packages
library(dplyr)
library(data.table)
library(tidyr)

# Collect meaningful Data sets into specific variables

# x_train_observe to have training dataset
x_train_observe <- read.csv("./UCI HAR Dataset/train/X_train.txt", header=F, sep="")
# x_test_observe to have test dataset
x_test_observe <- read.csv("./UCI HAR Dataset/test/X_test.txt", header=F, sep="")
# subjectRead to have parametric measurements carried out 
subjectRead <- read.csv("./UCI HAR Dataset/train/subject_train.txt", header=F)

# Extracts only the measurements on the mean and standard deviation for each measurement. 

# Modify standard R column headings with descriptive activity names
temp <- subjectRead$V2 
names(x_train_observe) <- temp 
names(x_test_observe) <- temp

# Convert into table form
xTrain_tbl <- tbl_df(x_train_observe) 
xTest_tbl <- tbl_df(x_test_observe)

# Remove unwanted readings
xTrain <- xTrain_tbl[ , !duplicated(colnames(xTrain_tbl))]   
xTest <- xTest_tbl[ , !duplicated(colnames(xTest_tbl))]

# Remove readings apart from "Mean", "std"
meanstdxTrain <- filter(select(xTrain, matches("Mean"), matches("std"))) 
meanstdxTest <- filter(select(xTest, matches("Mean"), matches("std")))

# Add subject ID column for Train and Test datasets
meanstdxTrain <- mutate(meanstdxTrain,ID = subjectTrain$V1)
meanstdxTest <- mutate(meanstdxTest, ID = subjectTest$V1)

# Create average of each variable for each activity and each subject
avg_meanstd_xTrain <- meanstdxTrain %>% group_by(ID) %>% summarise_each(c("mean"))
avg_meanstd_xTest <- meanstdxTest %>% group_by(ID) %>% summarise_each(c("mean"))

# Create tidy data set
l = list(avg_meanstd_xTrain,avg_meanstd_xTest) 
comb_train_test = rbindlist(l, use.names=TRUE, fill=TRUE) 

# Upload tidy data set as text file with write.table(), raw.name=FALSE
write.table(comb_train_test,file = "tidy.txt", row.names = FALSE)


