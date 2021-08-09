IMPORT ML_Core;
IMPORT DBSCAN;
IMPORT DBSCAN.tests.datasets.frogDS_Small AS frog_data;

//Import raw data
DBSCANds := frog_data.ds;
OUTPUT(DBSCANds, NAMED('InputDataset'));

//sequence your data that needs to be sequenced
ML_Core.AppendSeqID(DBSCANds,id,newDBSCANds);
// Convert raw data to NumericField format
ML_Core.ToField(newDBSCANds,DBSCANNF);

//Train DBSCAN model 
mod := DBSCAN.DBSCAN(0.3,10).Fit(DBSCANNF);

NumberOfClusters := DBSCAN.DBSCAN().Num_Clusters(mod);
NumberOfOutliers := DBSCAN.DBSCAN().Num_Outliers(mod);

OUTPUT(NumberOfClusters, NAMED('NumberOfClusters'));
OUTPUT(NumberOfOutliers, NAMED('NumberOfOutliers'));

//Analysis
SSS := ML_Core.Analysis.Clustering.SilhouetteScore(DBSCANNF,mod);
OUTPUT(sss,NAMED('Analysis'));