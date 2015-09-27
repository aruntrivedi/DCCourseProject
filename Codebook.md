---
title: "Codebook"
author: "Arun Trivedi"
date: "September 27, 2015"
output: html_document
---

This book contains the variables, the data, and any transformations or work that are performed to clean up the data on UCI HAR Dataset.zip.

"UCI HAR Dataset.zip" contains Training and Testing data of measurements carried out on a set of 30 subjects using Smartphones. The information is collected in text/csv files.  

Create below mentioned tidy data sets for future analysis:

1. single train, test dataset with descriptive variable names
2. avg. of each variable & activity  per subject

Step 1 : 
Download raw data file from internet

* fileUrl points to "UCI HAR Dataset.zip" 
* "runAnlysis.zip" is local folder having all unzip files. All files are .txt files format
* dplyr, data.table, tidyr are key packages used for data transformation needs and installed.

Step 2 : 
Collect meaningful Data sets into specific variables

* x_train_observe to have training dataset (./X_test.txt)
* x_test_observe to have test dataset
* subjectRead to have parametric measurements carried out (./subject_train.txt or ./subject_test.txt) 

Step 3 : 
Extracts only the measurements on the mean and standard deviation for each measurement. 

Step 4 : 
Modify standard R column headings with descriptive activity names using names(x_train_observe), names(x_test_observe) and assigned respective values

Step 5: 
Move all data.frames to table format suing xTrain_tbl, xTest_tbl 

* Remove unwanted readings from both tables suing  
* !duplicated(colnames()) for train & test tables and renamed as xTrain, xTest
* Remove readings apart from "Mean", "std" using filer() from both tables keeping table names unchanged
* Add subject ID column (mutate())for Train and Test datasets and renamed tables as meanstdxTrain, meanstdxTest 

Step 6 : 
merge(..., ID) with meanstd This is the first tidy dataset generated for each of 30 subjects mean & stanadrd deviation measurements for all parameters

Step 7 : 
Create second tidy data set (group_by ID and summarised) with average of each variable for each activity rand each subject named avg_meanstd_xTrain, avg_meanstd_xTest 

* combined (rbind) both data tables using lists named comb_train_test 

Step 8 : 
Upload tidy data set as text file with write.table(), raw.name=FALSE

Few Workspace Components Generated:
```
> ls()
 
 [4] "avg_meanstd_xTest"  "avg_meanstd_xTrain" 
 [7]  	                  "comb_train_test"                  
[28] "fileUrl"           
[40] ""meanstdxTest"       "meanstdxTrain"     
[49] "subjectRead"        "subjectTest"        "subjectTrain"      
[61] "x_test_observe"     "x_train_observe"    "xmlText"           
[64] "xTest"              "xTest_tbl"          "xTrain"            
[67] "xTrain_tbl" 

Dimensions of various tables used during processing:

> dim(x_train_observe)
[1] 7352  561
> dim(x_test_observe)
[1] 2947  561
> dim(subjectRead)
[1] 561   2
> dim(subjectTrain)
[1] 7352    1
> dim(subjectTest)
[1] 2947    1
> dim(meanstdxTrain)
[1] 7352   88
> dim(meanstdxTest)
[1] 2947   88
> dim(xTrain)
[1] 7352  477
> dim(xTest)
[1] 2947  477
> dim(avg_meanstd_xTrain)
[1] 21 88
> dim(avg_meanstd_xTest)
[1]  9 88
> dim(comb_train_test)
[1] 30 89
```

end of R Markdown document