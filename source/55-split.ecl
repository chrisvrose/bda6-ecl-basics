IMPORT $.datasrc.house;
//record
dsrecord := house.dsrecord;
//loading up the dataset -> housing prices        
ds := DATASET('~eclbasics::house_prices_data.csv',dsrecord,CSV(HEADING(1)) );


// we usually deal with a split ratio being a number between 0 and 1
// Let's choose a popular number .7 -> 70% train and test split.
splitRatio:= .7;

//let's shuffle 
dswithrnd:= project(ds, TRANSFORM({integer id,dsrecord}, SELF.id:= RANDOM(),SELF:=LEFT));
shuffledDS := PROJECT(SORT(dswithrnd,id),TRANSFORM({dsrecord},SELF:=LEFT));

recCount := COUNT(ds);
// 1 to split
trainds := shuffledDS[..(recCount*splitRatio)];
// split+1 to end
testDS :=  shuffledDS[(recCount*splitRatio+1)..];

OUTPUT([recCount]+[COUNT(trainds)]+[COUNT(testds)],NAMED('counts_orig_train_test'));

OUTPUT(shuffledDs[..10],NAMED('original_data'));
OUTPUT(trainds[..10],NAMED('trainds'));
OUTPUT(testds[..10],NAMED('testds'));
