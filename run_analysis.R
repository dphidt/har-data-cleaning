## Cleaning the UCI HAR Dataset.
##
## This code tidies up the UCI Human Activity Recognition Using
## Smartphones Data Set [1], available here:
##
##  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
##
## [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and
## Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity
## Recognition Using Smartphones. 21th European Symposium on Artificial
## Neural Networks, Computational Intelligence and Machine Learning,
## ESANN 2013. Bruges, Belgium 24-26 April 2013.
##
## We perform the following operations:
##
##   1. Merge the test and training datasets
##   2. Extract only mean and standard deviation features
##   3. Use the descriptive activity names
##   4. Label the dataset with descriptive names
##   5. Create a new summary dataset
##
## This is a solution to the programming project for the Coursera
## course "Getting and Cleaning Data."
##
## dphidt, GitHub @dphidt, 2017/07/17


# Download the UCI dataset from the website and unzip it.
#
# @param url The URL for the dataset zip archive (optional)
# @param data_dir Destination path, created if necessary (optional)
download.data <- function(url='', data_dir='data') {
    if (url == '') {
        url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
    }
 
    if (!file.exists(data_dir)) {
        dir.create(data_dir)
    }

    path <- file.path(data_dir, 'uci_data.zip')
    download.file(url, destfile=path, method='curl')
    unzip(path, exdir=data_dir)
    
    file.path(data_dir, 'UCI HAR Dataset')
}


# Load one of the datasets (test/train)
#
# @param path The path to the unzipped UCI data
# @param type The data type (`test` or `train`)
# @returns The dataset, with cleaning transforms applied
read.dataset <- function(path, type, ...) {
    # Read the dataset and labels
    xdata <- read.table(file.path(path, type, paste0('X_', type, '.txt')), ...)
    ydata <- read.table(file.path(path, type, paste0('y_', type, '.txt')), ...)

    # Extract measurements for means and standard deviations
    colNames <- read.table(file.path(path, 'features.txt'))
    keepCols <- grep('mean\\(\\)|std\\(\\)', colNames$V2)
    xdata <- xdata[,keepCols]
    
    # Normalize column names
    colNames <- tolower(colNames$V2[keepCols])
    colNames <- gsub('\\(\\)', '', colNames)
    colNames <- gsub('-', '', colNames)
    colNames <- gsub('^t', '', colNames)
    colNames <- gsub('^f', 'fft', colNames)
    colNames <- gsub('acc', 'accel', colNames)
    colNames <- gsub('gyro', 'gyroscope', colNames)
    colNames <- gsub('mag', 'magnitude', colNames)
    names(xdata) <- colNames

    # Attach subject IDs
    subjects <- read.table(file.path(path, type, paste0('subject_', type, '.txt')), ...)
    xdata <- cbind(xdata, subject=subjects$V1)
    
    # Attach activity labels
    actLabels <- read.table(file.path(path, 'activity_labels.txt'))
    labels <- actLabels$V2
    ydata$V1 <- factor(ydata$V1, actLabels$V1, labels=actLabels$V2)
    xdata <- cbind(xdata, activity=ydata$V1)
    
    xdata
}


# Summarize.
#
# Creates a new dataset from the input, with the same columns, but only
# the mean value for each variable for each subject/activity combination.
#
# See CodeBook.md for a full description of the output.
#
# @param dataset The dataset to summarize
# @returns Data frame with summary data
summary <- function(dataset) {
    library(dplyr)
    data.frame(dataset %>% group_by(.dots=c('subject', 'activity')) %>% summarize_all(funs(mean)))
}


# Run the analysis.
#
# Creates a dataset from a subset of the UCI HAR dataset.
#
# See CodeBook.md for a full description of the output.
#
# The default behavior is to download the dataset, but it can be read
# from disk if a path is provided. By default all rows are read, but this
# can be limited for testing, with the `nrows` argument.
#
# @param path The path to the unzipped UCI data (optional)
# @param nrows The number of rows from each of the test and train set to import
# @param outfile.clean Filename for the output cleaned dataset
# @param outfile.summary Filename for the output cleaned dataset
# @returns Data frame with means and standard deviations of measurements
run_analysis <- function(path='', nrows=-1,
                         outfile.clean='uci_clean.txt',
                         outfile.summary='uci_summary.txt') {
    # Download the dataset if necessary
    if (path == '') {
        path <- download.data()
    }

    # Read the test and training datasets
    test_data <- read.dataset(path, 'test', nrows=nrows)
    train_data <- read.dataset(path, 'train', nrows=nrows)

    # Merge into one dataset
    data <- rbind(test_data, train_data)

    # Summarize
    data_summary <- summary(data)
    
    # Write output
    write.table(data, file=outfile.clean, row.names=F)
    write.table(data_summary, file=outfile.summary, row.names=F)
}
