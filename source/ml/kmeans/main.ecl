IMPORT ML_Core;
IMPORT KMeans;
IMPORT Visualizer;

//Import raw example data
KMDs := KMeans.Test.Datasets.DSIris.ds;
OUTPUT(KMds, NAMED('InputDataset'));

//Hold the raw data in machine learning dataframes such as NumericField
// Add id to each record
ML_Core.AppendSeqID(KMDs, id, newKMDs);
// Transform the records to NumericField dataframe
ML_Core.ToField(newKMDs, KMNF);

//Initialization
Centroids := KMNF(id IN [1, 51, 101]);

//Setup model parameters
Max_iterations := 30;
Tolerance := 0.00;

//Train K-Means Model
//Setup the model
Pre_Model := KMeans.KMeans(Max_iterations, Tolerance);
//Train the model
Model := Pre_Model.Fit(KMNF(number < 5), Centroids(number < 5));

//Coordinates of cluster centers
Centers := KMeans.KMeans().Centers(Model);
OUTPUT(Centers, NAMED('Centers'));

Labels := KMeans.KMeans().Predict(Model, KMNF);
OUTPUT(Labels, NAMED('Labels'));

//Analysis
SSS := ML_Core.Analysis.Clustering.SilhouetteScore(KMNF,Labels);
OUTPUT(sss,NAMED('Analysis'));