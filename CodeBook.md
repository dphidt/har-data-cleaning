Code Book: Tidy HAR Data Set
============================
This document describes the variables in the raw HAR dataset [1],
the output variables in a tidied-up version, and the transformations
applied in between. See `README.md` for a description of the project
and the code in this repository.

[1] http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Input Data
----------
Attributes in the raw HAR dataset include:

* Triaxial acceleration and estimated total body acceleration
* Triaxial angular velocity
* 561-feature vector containing time- and frequency-domain data
* A label for the type of activity
* A label indentifying the subject

The data are split into a training (70% of subjects) and test (30%)
subsets.

Within the test and training sets, the data are split across three
files, containing (1) the measurements, (2) the integer activity
label, and (3) the integer subject ID number. The activity labels
range between 1 and 6:
```
1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING
```

The measurements consist of 561 columns of floating point values,
derived from measurements. The base measurements include:

```
tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag
```

where `-XYZ` is shorthand for three variables, one for each Cartesian
axis, for 33 metrics total. Using these metrics, the following summary
variables were derived:

```
mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values.
iqr(): Interquartile range
entropy(): Signal entropy
arCoeff()*: Autorregresion coefficients with Burg order equal to 4  (4 columns each for XYZ)
correlation()*: correlation coefficient between two signals  (one column for each of XY, XZ, YZ)
maxInds()**: index of the frequency component with largest magnitude
meanFreq()**: Weighted average of the frequency components to obtain a mean frequency
skewness()**: skewness of the frequency domain signal
kurtosis()**: kurtosis of the frequency domain signal
bandsEnergy()**: Energy of a frequency interval within the 64 bins of the FFT of each window.
angle()**: Angle between to vectors.
```
where `*` (`**`) indicates a quantity only computed for time-
(frequency-)domain metrics. The column names for the measurements
are formed as `MEASUREMENT-SUMMARYVAR-DIMENSION`. So for example,
one column would be `tBodyAcc-mean()-X`.

For a concrete example, the list of columns corresponding to one
triaxial time-domain measurement would be:

```
1 tBodyAcc-mean()-X
2 tBodyAcc-mean()-Y
3 tBodyAcc-mean()-Z
4 tBodyAcc-std()-X
5 tBodyAcc-std()-Y
6 tBodyAcc-std()-Z
7 tBodyAcc-mad()-X
8 tBodyAcc-mad()-Y
9 tBodyAcc-mad()-Z
10 tBodyAcc-max()-X
11 tBodyAcc-max()-Y
12 tBodyAcc-max()-Z
13 tBodyAcc-min()-X
14 tBodyAcc-min()-Y
15 tBodyAcc-min()-Z
16 tBodyAcc-sma()
17 tBodyAcc-energy()-X
18 tBodyAcc-energy()-Y
19 tBodyAcc-energy()-Z
20 tBodyAcc-iqr()-X
21 tBodyAcc-iqr()-Y
22 tBodyAcc-iqr()-Z
23 tBodyAcc-entropy()-X
24 tBodyAcc-entropy()-Y
25 tBodyAcc-entropy()-Z
26 tBodyAcc-arCoeff()-X,1
27 tBodyAcc-arCoeff()-X,2
28 tBodyAcc-arCoeff()-X,3
29 tBodyAcc-arCoeff()-X,4
30 tBodyAcc-arCoeff()-Y,1
31 tBodyAcc-arCoeff()-Y,2
32 tBodyAcc-arCoeff()-Y,3
33 tBodyAcc-arCoeff()-Y,4
34 tBodyAcc-arCoeff()-Z,1
35 tBodyAcc-arCoeff()-Z,2
36 tBodyAcc-arCoeff()-Z,3
37 tBodyAcc-arCoeff()-Z,4
38 tBodyAcc-correlation()-X,Y
39 tBodyAcc-correlation()-X,Z
40 tBodyAcc-correlation()-Y,Z
```

And an example for a frequency-domain metric:

```
266 fBodyAcc-mean()-X
267 fBodyAcc-mean()-Y
268 fBodyAcc-mean()-Z
269 fBodyAcc-std()-X
270 fBodyAcc-std()-Y
271 fBodyAcc-std()-Z
272 fBodyAcc-mad()-X
273 fBodyAcc-mad()-Y
274 fBodyAcc-mad()-Z
275 fBodyAcc-max()-X
276 fBodyAcc-max()-Y
277 fBodyAcc-max()-Z
278 fBodyAcc-min()-X
279 fBodyAcc-min()-Y
280 fBodyAcc-min()-Z
281 fBodyAcc-sma()
282 fBodyAcc-energy()-X
283 fBodyAcc-energy()-Y
284 fBodyAcc-energy()-Z
285 fBodyAcc-iqr()-X
286 fBodyAcc-iqr()-Y
287 fBodyAcc-iqr()-Z
288 fBodyAcc-entropy()-X
289 fBodyAcc-entropy()-Y
290 fBodyAcc-entropy()-Z
291 fBodyAcc-maxInds-X
292 fBodyAcc-maxInds-Y
293 fBodyAcc-maxInds-Z
294 fBodyAcc-meanFreq()-X
295 fBodyAcc-meanFreq()-Y
296 fBodyAcc-meanFreq()-Z
297 fBodyAcc-skewness()-X
298 fBodyAcc-kurtosis()-X
299 fBodyAcc-skewness()-Y
300 fBodyAcc-kurtosis()-Y
301 fBodyAcc-skewness()-Z
302 fBodyAcc-kurtosis()-Z
303 fBodyAcc-bandsEnergy()-1,8
304 fBodyAcc-bandsEnergy()-9,16
305 fBodyAcc-bandsEnergy()-17,24
306 fBodyAcc-bandsEnergy()-25,32
307 fBodyAcc-bandsEnergy()-33,40
308 fBodyAcc-bandsEnergy()-41,48
309 fBodyAcc-bandsEnergy()-49,56
310 fBodyAcc-bandsEnergy()-57,64
311 fBodyAcc-bandsEnergy()-1,16
312 fBodyAcc-bandsEnergy()-17,32
313 fBodyAcc-bandsEnergy()-33,48
314 fBodyAcc-bandsEnergy()-49,64
315 fBodyAcc-bandsEnergy()-1,24
316 fBodyAcc-bandsEnergy()-25,48
317 fBodyAcc-bandsEnergy()-1,8
318 fBodyAcc-bandsEnergy()-9,16
319 fBodyAcc-bandsEnergy()-17,24
320 fBodyAcc-bandsEnergy()-25,32
321 fBodyAcc-bandsEnergy()-33,40
322 fBodyAcc-bandsEnergy()-41,48
323 fBodyAcc-bandsEnergy()-49,56
324 fBodyAcc-bandsEnergy()-57,64
325 fBodyAcc-bandsEnergy()-1,16
326 fBodyAcc-bandsEnergy()-17,32
327 fBodyAcc-bandsEnergy()-33,48
328 fBodyAcc-bandsEnergy()-49,64
329 fBodyAcc-bandsEnergy()-1,24
330 fBodyAcc-bandsEnergy()-25,48
331 fBodyAcc-bandsEnergy()-1,8
332 fBodyAcc-bandsEnergy()-9,16
333 fBodyAcc-bandsEnergy()-17,24
334 fBodyAcc-bandsEnergy()-25,32
335 fBodyAcc-bandsEnergy()-33,40
336 fBodyAcc-bandsEnergy()-41,48
337 fBodyAcc-bandsEnergy()-49,56
338 fBodyAcc-bandsEnergy()-57,64
339 fBodyAcc-bandsEnergy()-1,16
340 fBodyAcc-bandsEnergy()-17,32
341 fBodyAcc-bandsEnergy()-33,48
342 fBodyAcc-bandsEnergy()-49,64
343 fBodyAcc-bandsEnergy()-1,24
344 fBodyAcc-bandsEnergy()-25,48
```

For the `angle()` variable, a few additional variables are calculated:

```
gravityMean: Mean acceleration due to gravity
tBodyAccMean: Mean total body acceleration
tBodyAccJerkMean: Mean total body jerk
tBodyGyroMean: Mean total angular velocity
tBodyGyroJerkMean: Derivative of angular acceleration
```

The full set of `angle` metrics include:

```
555 angle(tBodyAccMean,gravity)
556 angle(tBodyAccJerkMean),gravityMean)
557 angle(tBodyGyroMean,gravityMean)
558 angle(tBodyGyroJerkMean,gravityMean)
559 angle(X,gravityMean)
560 angle(Y,gravityMean)
561 angle(Z,gravityMean)
```

The complete list of 561 features is listed in `features.txt` the
root directory of the HAR dataset.

### Units ###
Per the dataset `README.txt`, all features are normalized and
bounded within [-1,1].

Output Data
-----------
To simplify the data for analysis, we extract only the variables corresponding
to means and standard deviations, convert labels to R levels, and rename the
columns to be more descriptive. Additionally, the training and test datasets
are combined into one.

### Data Transformations ###
The required columns are selected by searching the column names for
the strings `mean()` and `std()`, and normalized as follows:

1. Convert to lower case
2. Remove parentheses and dashes
3. Remove initial 't' characters  (time domain the default case)
4. Change nitial 'f' characters to 'fft' for clarity
5. Expand 'acc' to 'accel'
6. Expand 'gyro' to 'gyroscope'
7. Expand 'mag' to 'magnitude'

The activity labels given above are merged into the dataset as an
additional column, with the integer IDs replaced by factor levels
corresponding to the string descriptions.

Finally, the integer subject IDs are merged into the dataset as an
additional column.

### Data Format ###
The full list of columns in the output data is:

```
1 subject: Subject (participant) ID number
2 activity: Activity label (see list above) as factor with 6 levels
3 bodyaccelmeanx: Mean body acceleration, X dimension
4 bodyaccelmeany: Mean body acceleration, Y dimension
5 bodyaccelmeanz: Mean body acceleration, Z dimension
6 bodyaccelstdx: Standard deviation of body acceleration, X dimension
7 bodyaccelstdy: Standard deviation of body acceleration, Y dimension
8 bodyaccelstdz: Standard deviation of body acceleration, Z dimension
9 gravityaccelmeanx: Mean acceleration due to gravity, X dimension
10 gravityaccelmeany: Mean acceleration due to gravity, Y dimension
11 gravityaccelmeanz: Mean acceleration due to gravity, Z dimension
12 gravityaccelstdx: Standard deviation of acceleration due to gravity, X dimension
13 gravityaccelstdy: Standard deviation of acceleration due to gravity, Y dimension
14 gravityaccelstdz: Standard deviation of acceleration due to gravity, Z dimension
15 bodyacceljerkmeanx: Mean derivative of body acceleration (jerk), X dimension
16 bodyacceljerkmeany: Mean derivative of body acceleration (jerk), Y dimension
17 bodyacceljerkmeanz: Mean derivative of body acceleration (jerk), Z dimension
18 bodyacceljerkstdx: Standard deviation of derivative of body acceleration (jerk), X dimension
19 bodyacceljerkstdy: Standard deviation of derivative of body acceleration (jerk), Y dimension
20 bodyacceljerkstdz: Standard deviation of derivative of body acceleration (jerk), Z dimension
21 bodygyroscopemeanx: Mean angular velocity, X dimension
22 bodygyroscopemeany: Mean angular velocity, Y dimension
23 bodygyroscopemeanz: Mean angular velocity, Z dimension
24 bodygyroscopestdx: Standard deviation of angular velocity, X dimension
25 bodygyroscopestdy: Standard deviation of angular velocity, Y dimension
26 bodygyroscopestdz: Standard deviation of angular velocity, Z dimension
27 bodygyroscopejerkmeanx: Mean derivative of angular velocity, X dimension
28 bodygyroscopejerkmeany: Mean derivative of angular velocity, Y dimension
29 bodygyroscopejerkmeanz: Mean derivative of angular velocity, Z dimension
30 bodygyroscopejerkstdx: Standard deviation of derivative of angular velocity, X dimension
31 bodygyroscopejerkstdy: Standard deviation of derivative of angular velocity, Y dimension
32 bodygyroscopejerkstdz: Standard deviation of derivative of angular velocity, Z dimension
33 bodyaccelmagnitudemean: Mean total body acceleration
34 bodyaccelmagnitudestd: Standard deviation of total body acceleration
35 gravityaccelmagnitudemean: Mean total acceleration due to gravity
36 gravityaccelmagnitudestd: Standard deviation of total acceleration due to gravity
37 bodyacceljerkmagnitudemean: Mean derivative of total body acceleration (jerk)
38 bodyacceljerkmagnitudestd: Standard deviation of derivative of total body acceleration (jerk)
39 bodygyroscopemagnitudemean: Mean of total angular acceleration
40 bodygyroscopemagnitudestd: Standard deviation of total angular acceleration
41 bodygyroscopejerkmagnitudemean: Mean of derivative of total angular acceleration
42 bodygyroscopejerkmagnitudestd: Standard deviation of derivative of total angular acceleration
43 fftbodyaccelmeanx: Mean of FFT of body acceleration, X dimension
44 fftbodyaccelmeany: Mean of FFT of body acceleration, Y dimension
45 fftbodyaccelmeanz: Mean of FFT of body acceleration, Z dimension
46 fftbodyaccelstdx: Standard deviation of FFT of body acceleration, X dimension
47 fftbodyaccelstdy: Standard deviation of FFT of body acceleration, Y dimension
48 fftbodyaccelstdz: Standard deviation of FFT of body acceleration, Z dimension
49 fftbodyacceljerkmeanx: Mean of FFT of derivative of body acceleration, X dimension
50 fftbodyacceljerkmeany: Mean of FFT of derivative of body acceleration, Y dimension
51 fftbodyacceljerkmeanz: Mean of FFT of derivative of body acceleration, Z dimension
52 fftbodyacceljerkstdx: Standard deviation of FFT of derivative of body acceleration, X dimension
53 fftbodyacceljerkstdy: Standard deviation of FFT of derivative of body acceleration, Y dimension
54 fftbodyacceljerkstdz: Standard deviation of FFT of derivative of body acceleration, Z dimension
55 fftbodygyroscopemeanx: Mean of FFT of body angular velocity, X dimension
56 fftbodygyroscopemeany: Mean of FFT of body angular velocity, Y dimension
57 fftbodygyroscopemeanz: Mean of FFT of body angular velocity, Y dimension
58 fftbodygyroscopestdx: Standard deviation of FFT of body angular velocity, X dimension
59 fftbodygyroscopestdy: Standard deviation of FFT of body angular velocity, Y dimension
60 fftbodygyroscopestdz: Standard deviation of FFT of body angular velocity, Z dimension
61 fftbodyaccelmagnitudemean: Mean of FFT of total acceleration
62 fftbodyaccelmagnitudestd: Standard deviation of FFT of total acceleration
63 fftbodybodyacceljerkmagnitudemean: Mean of FFT of derivative of total acceleration
64 fftbodybodyacceljerkmagnitudestd: Standard deviation of FFT of derivative of total acceleration
65 fftbodybodygyroscopemagnitudemean: Mean of FFT of total angular velocity
66 fftbodybodygyroscopemagnitudestd: Standard deviation of FFT of total angular velocity
67 fftbodybodygyroscopejerkmagnitudemean: Mean of FFT of derivative of total angular velocity
68 fftbodybodygyroscopejerkmagnitudestd: Standard deviation of FFT of derivative of total angular velocity
```

Units for the features are the same as the input data, i.e. normalized and
bounded within the range [-1, 1].

A dataset with this format is created from the raw data by running
the `run_analysis` function within `run_analysis.R`. See `README.md`
for more details.

Summary Table
-------------
The summary dataset (created by `summary()`, see `README.md` for details)
has the same columns as listed in the previous section, however there is
one entry for each subject for each activity (i.e. 180 rows, for 6 activities
for 30 subjects), containing the mean of all corresponding measurements in
the full dataset.
