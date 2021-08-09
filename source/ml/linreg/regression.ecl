IMPORT ML_Core;
IMPORT LearningTrees; // Using Learning Trees regression as example
IMPORT $ as root; // Importing directory to get dataset

RFRegDs := root.Datasets.houseDs.Ds; // Irrelevant dataset, just as an example

// Counting total number of records to split dataset
recordCount := COUNT(RFRegDs);
splitRatio := 0.8;

// Shuffling dataset using shuffler record and sorting
Shuffler := RECORD(RECORDOF(RFRegDs))
  UNSIGNED4 rnd; // A random number
END;

newDs := PROJECT(RFRegDs, TRANSFORM(Shuffler, SELF.rnd := RANDOM(), SELF := LEFT));

// Sorts dataset over random numbers to shuffle
shuffledDs := SORT(newDs, rnd);

// Split train and test datasets
TrainDs := PROJECT(shuffledDs[1..(recordCount * splitRatio)], RECORDOF(RFRegDs));
TestDs := PROJECT(shuffledDs[(recordCount*splitRatio + 1)..recordCount], RECORDOF(RFRegDs));

OUTPUT(TrainDs, NAMED('TrainDataset'));
OUTPUT(TestDs, NAMED('TestDataset'));

// Append ID to use with NumericField 
ML_Core.AppendSeqID(TrainDs, id, newTrain);
ML_Core.AppendSeqID(TestDs, id, newTest);

OUTPUT(newTrain, NAMED('TrainDatasetID'));
OUTPUT(newTest, NAMED('TestDatasetID'));

// Convert datasets to Numeric Field type
ML_Core.ToField(newTrain, TrainNF);
ML_Core.ToField(newTest, TestNF);

OUTPUT(TrainNF, NAMED('TrainNumericField'));
OUTPUT(TestNF, NAMED('TestNumericField'));

// Seperate dataset into dependent(y) and independent(x) variables
independent_cols := 12;

X_train := TrainNF(number < independent_cols + 1);
y_train := PROJECT(TrainNF(number = independent_cols + 1), TRANSFORM(RECORDOF(LEFT), SELF.number := 1, SELF := LEFT));

X_test := TestNF(number < independent_cols + 1);
y_test := PROJECT(TestNF(number = independent_cols + 1), TRANSFORM(RECORDOF(LEFT), SELF.number := 1, SELF := LEFT));

OUTPUT(y_test, NAMED('ActualY'));

// Build the regressor by fitting model on data
regressor := LinearRegression.OLS(X_train, y_train).GetModel;

// Predict using obtained regressor
predicted := LinearRegression.OLS().Predict(X_test, regressor);

OUTPUT(predicted, NAMED('PredictedY'));

// Calculate accuracy of model to analyse model (The method talked about)
accuracy_values := ML_Core.Analysis.Regression.Accuracy(predicted, y_test);
OUTPUT(accuracy_values, NAMED('AccuracyValues'));