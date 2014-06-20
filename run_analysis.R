## This function works on accomplisihng the following
	## Consolidate subject, Activity and Training Statistics Data
	## Extract required columns (mean and std cols) and add correct labels
	## Substitute Activity Id with Activity Name
	## Consolidate subject, Activity and Test Statistics Data
	## Extract required columns (mean and std cols) and add correct labels   
	## Substitute Activity Id with Activity Name                             
	## Consolidate subject, Activity and Training Statistics Data            
	## Merge the Test and Training Data and print the tidy data to console
##

run_analysis <- function() {


## Load the files for training data

subject_train <- read.table("train/subject_train.txt", quote="\"")

## add a logically relevant column name 
names(subject_train)[names(subject_train)=="V1"] <- "subject_id"


X_train <- read.table("train/X_train.txt", quote="\"")

y_train <- read.table("train/y_train.txt", quote="\"")

## add a logically relevant column name 

names(y_train)[names(y_train)=="V1"] <- "activity_id"

## Consolidate the data from the three sources for training data and create a raw dataset

rAwTrainData <- cbind(subject_train,y_train,X_train)

## Load the features/functions data

features <- read.table("features.txt", quote="\"")

## add a logically relevant column name 

names(features)[names(features)=="V1"] <- "id"

names(features)[names(features)=="V2"] <- "FeatureFunction"


## Fetch the methods/functions w.r.t. mean

filteredMeanFeatures <- features[grep("+mean()+", as.character(features$FeatureFunction)),]

## Fetch the methods/functions w.r.t. standard deviation

filteredStdFeatures <- features[grep("+std()+", as.character(features$FeatureFunction)),]

## consolidate the two lists into one

filteredFeatures <- rbind(filteredMeanFeatures,filteredStdFeatures)

filteredFeatures <- filteredFeatures[order(filteredFeatures$id),]

## Using the function names from features data frame , clean the data from raw training dataset 

names <- vector()
cnames <- vector()
for(i in filteredFeatures$id){
names[length(names)+1] <- gsub(" ","",paste("rAwTrainData$",paste("V",i)))
filter <- filteredFeatures[which(filteredFeatures$id == i),]
cnames[length(cnames)+1] <- as.character(filter$FeatureFunction)
}
cleanTrain <- data.frame(matrix(nrow=nrow(rAwTrainData), ncol=nrow(filteredFeatures)))

## Add the functions as the column names to the tidy training data

colnames(cleanTrain) <- cnames

## Populate the data to the tidy dataset

for(j in 1:length(cleanTrain)){
cleanTrain[j] <- eval(parse(text=names[j]))
}


## Parse and Process Activity Label and replace them in the raw dataset and in the tidy dataset

cleanTrain <- cbind(Activity=0,cleanTrain)
rAwTrainData$activity_id <- as.character(rAwTrainData$activity_id)
rAwTrainData$activity_id[rAwTrainData$activity_id == "1"] <- "WALKING"
rAwTrainData$activity_id[rAwTrainData$activity_id == "2"] <- "WALKING_UPSTAIRS"
rAwTrainData$activity_id[rAwTrainData$activity_id == "3"] <- "WALKING_DOWNSTAIRS"
rAwTrainData$activity_id[rAwTrainData$activity_id == "4"] <- "SITTING"
rAwTrainData$activity_id[rAwTrainData$activity_id == "5"] <- "STANDING"
rAwTrainData$activity_id[rAwTrainData$activity_id == "6"] <- "LAYING"

cleanTrain$Activity <- rAwTrainData$activity_id

## Add the subject id to the tidy training data 
cleanTrain <- cbind(SubjectID=0,cleanTrain)

cleanTrain$SubjectID <- rAwTrainData$subject_id


## Load the files for test data

subject_test <- read.table("test/subject_test.txt", quote="\"")

## add a logically relevant column name 

names(subject_test)[names(subject_test)=="V1"] <- "subject_id"

X_test <- read.table("test/X_test.txt", quote="\"")

y_test <- read.table("test/y_test.txt", quote="\"")

## add a logically relevant column name 

names(y_test)[names(y_test)=="V1"] <- "activity_id"

rAwTestData <- cbind(subject_test,y_test,X_test)


## Using the function names from features data frame , clean the data from raw test dataset 

names <- vector()
cnames <- vector()
for(i in filteredFeatures$id){
names[length(names)+1] <- gsub(" ","",paste("rAwTestData$",paste("V",i)))
filter <- filteredFeatures[which(filteredFeatures$id == i),]
cnames[length(cnames)+1] <- as.character(filter$FeatureFunction)
}
cleanTest <- data.frame(matrix(nrow=nrow(rAwTestData), ncol=nrow(filteredFeatures)))

## Add the functions as the column names to the tidy training data

colnames(cleanTest) <- cnames

## Populate the data to the tidy dataset

for(j in 1:length(cleanTest)){
cleanTest[j] <- eval(parse(text=names[j]))
}
cleanTest <- cbind(Activity=0,cleanTest)

## Parse and Process Activity Label and replace them in the raw dataset and in the tidy dataset

rAwTestData$activity_id <- as.character(rAwTestData$activity_id)
rAwTestData$activity_id[rAwTestData$activity_id == "1"] <- "WALKING"
rAwTestData$activity_id[rAwTestData$activity_id == "2"] <- "WALKING_UPSTAIRS"
rAwTestData$activity_id[rAwTestData$activity_id == "3"] <- "WALKING_DOWNSTAIRS"
rAwTestData$activity_id[rAwTestData$activity_id == "4"] <- "SITTING"
rAwTestData$activity_id[rAwTestData$activity_id == "5"] <- "STANDING"
rAwTestData$activity_id[rAwTestData$activity_id == "6"] <- "LAYING"

cleanTest$Activity <- rAwTestData$activity_id

## Add the subject id to the tidy test data 

cleanTest <- cbind(SubjectID=0,cleanTest)

cleanTest$SubjectID <- rAwTestData$subject_id

## Merge the tidy datasets from training and test sources and generate a consolidated tidy dataset for the problem solution

tidyData <- merge(cleanTrain,cleanTest,all=TRUE)

## Write the Tidy Data Set to a File , Commented for now
##write.csv(tidyData, file = "tidyData.csv")

tidyData

}
