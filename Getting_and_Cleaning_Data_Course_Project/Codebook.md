## Code book for Coursera Getting and Cleaning Data course project

The data set that this code book pertains to is located in the tidydata.txt file of this repository.

See the README.md file of this repository for background information on this data set.

## Data
The tidydata.txt data file is a text file, containing space-separated values.

The first row contains the names of the variables, which are listed and described in the 
Variables section, and the following rows contain the values of these variables.

## Variables
Each row contains, for a given subject and activity, 79 averaged signal measurements.

## Identifiers
* subject
    Subject identifier, integer, ranges from 1 to 30.

* activity
    Activity identifier, string with 6 possible values:
  
    * WALKING: subject was walking
    * WALKING_UPSTAIRS: subject was walking upstairs
    * WALKING_DOWNSTAIRS: subject was walking downstairs
    * SITTING: subject was sitting
    * STANDING: subject was standing
    * LAYING: subject was laying
    
##Average of measurements
    All measurements are floating-point values, normalised and bounded within [-1,1].
    
* The measurements are classified in two domains:
      
  * Time-domain signals (variables prefixed by timeDomain), resulting from the capture of accelerometer and gyroscope raw signals.
  * Frequency-domain signals (variables prefixed by frequencyDomain), resulting from the application of a Fast Fourier Transform (FFT) to some of the time-domain signals.

* These signals were used to estimate variables of the feature vector for each pattern:
  '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

    * timeBodyAccelerometer-XYZ
    * timeGravityAccelerometer-XYZ
    * timeBodyAccelerometerJerk-XYZ
    * timeBodyGyroscope-XYZ
    * timeBodyGyroscopeJerk-XYZ
    * timeBodyAccelerometerMagnitude
    * timeGravityAccelerometerMagnitude
    * timeBodyAccelerometerJerkMagnitude
    * timeBodyGyroscopeMagnitude
    * timeBodyGyroscopeJerkMagnitude
    * frequencyBodyAccelerometer-XYZ
    * frequencyBodyAccelerometerJerk-XYZ
    * frequencyBodyGyroscope-XYZ
    * frequencyBodyAccelerometerMagnitude
    * frequencyBodyAccelerometerJerkMagnitude
    * frequencyBodyGyroscopeMagnitude
    * frequencyBodyGyroscopeJerkMagnitude
    
The set of variables that were estimated from these signals are:
      
    * mean(): Mean value
    * std(): Standard deviation    
    