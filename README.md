UCI Human Activity Recognition Dataset
======================================
This code takes datasets from the UCI Human Activity Recognition
Using Smartphones (HAR) project, and transforms them to a tidy
dataset for easier analysis.

Project Background
------------------
In the HAR project [1], a group of 30 subjects performed a set of
common activities while wearing a Samsung Galaxy S smartphone.
Activities included: walking, walking up stairs, walking down
stairs, sitting, standing, and laying down. The outputs from the
embedded triaxial accelerometer and gyroscope were recorded, with
a sample rate of 50 Hz. The raw data were processed with noise and
bandpass filtering, and power spectra were extracted using a
Fourier transform. These data were subsequently split into training
and test datasets and input into a machine learning (ML) system, to
explore the efficacy of ML to identify human behaviors using
commonplace wearable sensors. Further details are available on the
project website [2].

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and
Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity
Recognition Using Smartphones. 21th European Symposium on Artificial
Neural Networks, Computational Intelligence and Machine Learning,
ESANN 2013. Bruges, Belgium 24-26 April 2013.

[2] http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Analysis Code
-------------
This repository contains a script `run_analysis.R` which can
download the HAR dataset and tidy it up for analysis. The input
format, transformations, and output format are described in
`CodeBook.md`.

### Usage ###

To produce the tidy dataset and store it as `d`, run: 

```R
source('run_analysis.R')
d <- run_analysis()
```

This creates two output files:

* `uci_clean.txt`: A cleaned dataset
* `uci_summary.txt`: A summary dataset

For full details on the format of these files, see `CodeBook.md`.

Notes
-----
This code is a solution to the course project for the Coursera course
"Getting and Cleaning Data."
