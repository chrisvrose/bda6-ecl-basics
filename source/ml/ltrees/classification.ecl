IMPORT ML_Core;
IMPORT LearningTrees; // We are using Learning Trees here. Shall be covered in a further chapter
IMPORT $ as root; // Importing current folder to get dataset

RFClassDs := root.Datasets.heartDs.Ds; // This is a dataset that is not relevant to us, it's just an example

// Get count of how many records to split to train and test dataset
recordCount := COUNT(RFClassDs);
splitRatio := 0.8;

// Record that is used to shuffle dataset
Shuffler := RECORD(RECORDOF(RFClassDs))
  UNSIGNED4 rnd; // A random number
END;

newDs := PROJECT(RFClassDs, TRANSFORM(Shuffler, SELF.rnd := RANDOM(), SELF := LEFT)); 

shuffledDs := SORT(newDs, rnd); // Shuffle by sorting a list of random numbers

// Train and Test dataset splitting
TrainDs := PROJECT(shuffledDs[1..(recordCount * splitRatio)], RECORDOF(RFClassDs));
TestDs := PROJECT(shuffledDs[(recordCount*splitRatio + 1)..recordCount], RECORDOF(RFClassDs));

OUTPUT(TrainDs, NAMED('TrainDataset'));
OUTPUT(TestDs, NAMED('TestDataset'));

// Appending IDs as the original data does not have it
ML_Core.AppendSeqID(TrainDs, id, newTrain);
ML_Core.AppendSeqID(TestDs, id, newTest);

OUTPUT(newTrain, NAMED('TrainDatasetID'));
OUTPUT(newTest, NAMED('TestDatasetID'));

// Converting data to Numeric Field
ML_Core.ToField(newTrain, TrainNF);
ML_Core.ToField(newTest, TestNF);

OUTPUT(TrainNF, NAMED('TrainNumericField'));
OUTPUT(TestNF, NAMED('TestNumericField'));

// Getting dependent(y) and independent(x) variables separated in both train and test datasets
independent_cols := 13;

X_train := TrainNF(number < independent_cols + 1);
y_train := ML_Core.Discretize.ByRounding(PROJECT(TrainNF(number = independent_cols + 1), TRANSFORM(RECORDOF(LEFT), SELF.number := 1, SELF := LEFT)));

X_test := TestNF(number < independent_cols + 1);
y_test := ML_Core.Discretize.ByRounding(PROJECT(TestNF(number = independent_cols + 1), TRANSFORM(RECORDOF(LEFT), SELF.number := 1, SELF := LEFT)));

OUTPUT(y_test, NAMED('ActualY'));

// Check the class stats of testY (1st function)
stats := ML_Core.Analysis.Classification.ClassStats(y_test);
OUTPUT(stats, NAMED('ClassStats'));

// Learning Trees Classifier model fitting over train set
classifier := LearningTrees.ClassificationForest().GetModel(X_train, y_train);

// Predicting over fitted model with test dataset
predicted := LearningTrees.ClassificationForest().Classify(classifier, X_test);
OUTPUT(predicted, NAMED('PredictedY'));

// Generate confusion matrix with predicted and actual values (2nd function)
cm := ML_Core.Analysis.Classification.ConfusionMatrix(predicted, y_test);
OUTPUT(cm, NAMED('ConfusionMatrix'));

// Calculate overall classification accuracy of model (3rd function)
accuracy_values := ML_Core.Analysis.CLassification.Accuracy(predicted, y_test);
OUTPUT(accuracy_values, NAMED('AccuracyValues'));

// Calculate classification accuracy by class of model (4th function)
accuracy_by_class := ML_Core.Analysis.Classification.Accuracy(predicted, y_test);
OUTPUT(accuracy_by_class, NAMED('AccuracyByClass'));