// getting every third element
n:= 3;

// record and dataset
rec:= {unsigned age,unsigned estimatedsalary,unsigned purchased};
ds := dataset('~eclbasics::Social_Network_Ads.csv',rec,CSV(HEADING(1)));

//add an id to it, so we can see the effects
recid:={integer id,rec};
dsid := project(ds,TRANSFORM(recid, self.id:=COUNTER,SELF := LEFT));

// output(dsid);
// method 1 - filters
dsf := dsid(id%n=1); // remember, its 1 indexed

//get the first ten records for looking at -> look at the id values
OUTPUT(dsf[..10],named('filt_op'));
OUTPUT(COUNT(dsf),named('count_op'));

