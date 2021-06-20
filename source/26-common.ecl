// define the record inline, instead of the usual RECORD END; style
rec:= {unsigned age,unsigned estimatedsalary,unsigned purchased};
ds := dataset('~eclbasics::Social_Network_Ads.csv',rec,CSV(HEADING(1)));

//a brief output
segment:= choosen(ds,15);
output(segment);
// we can choose which parts to output 
// note that the first argument must be a record in this case
output(segment,{age,estimatedsalary});

//filtering some data - let's get who all purchased
purchased := ds(purchased=1);
//let's print some of it
output(CHOOSEN(purchased,15),NAMED('purchased'));

// how about those who purchased and are younger than me(21)
purchasedYngCount := ds(purchased = 1 AND age<21);

// the result of one function can be passed into another function, no problem
output(COUNT(purchasedYngCount),NAMED('countofYoung'));

// we have seen one way to do vertical slices for output, let's consider some other ways

// Projects - inline transform
dscols:=PROJECT(ds,TRANSFORM({unsigned age, unsigned estimatedsalary}, SELF := LEFT));
output(CHOOSEN(dscols,10),named('projections'));


//let's add some ids
recwithId:= RECORD
    // the serial #
    integer id;
    // we can use an existing record and 'extend' it
    rec;
END;
// make a transform function
recwithid addId(rec L, INTEGER c) := TRANSFORM
    // assign id, from the counter argument
    self.id:= c;
    // assign to left
    SELF := L;
END;

dswithId:= PROJECT(ds,addid(LEFT,COUNTER));
output(CHOOSEN(dswithId,10),NAMED('with_id'));