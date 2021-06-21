import std;

ds:=DATASET('~eclbasics::vocab.enron.txt',{string f1},csv);

pl := ds(ds.f1=STD.Str.Reverse(ds.f1));

//output every 8th word from word 2
OUTPUT(SAMPLE(pl,8,2),named('plSample'));

output(COUNT(pl),NAMED('plCount'));
