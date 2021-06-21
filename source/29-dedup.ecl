// data definition and inline record
SomeFile := DATASET([{'001','KC','G'}, 
                     {'003','KC','Z'}, 
                     {'005','KA','X'}, 
                     {'006','KB','A'}, 
                     {'002','KC','Z'}, 
                     {'007','KB','G'}, 
                     {'004','KC','C'}, 
                     {'008','KA','B'}],{STRING3 Id, String2 Value1, String1 Value2});

// sorted variant
SomeFileSorted := SORT(SomeFile, Value1);

// sort, column
d1:= dedup(somefilesorted,value1);
// no sort col not all
d2 := dedup(somefile,value1);
// no sort col all
d3 := dedup(somefile,value1,all);


// some other arguments of dedup -> BEST() -> pick which column to pick
d4 := dedup(somefilesorted,value1,best(value2));

// outputs
d1;
d2;
d3;
d4;