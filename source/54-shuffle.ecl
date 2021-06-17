IMPORT $.datasrc.house;
//record
dsrecord := house.dsrecord;
//loading up the dataset -> housing prices        
ds := DATASET('~eclbasics::house_prices_data.csv',dsrecord,CSV(HEADING(1)) );

//new record extending the older one by adding an id field
dsrecwithrnd:= RECORD
	integer id;
	dsrecord;
end;

//use the id column as a random field
//This is a shorthand for transform
//self, left, counter are predefined in this scope
dswithrnd:= project(ds, TRANSFORM(dsrecwithrnd, SELF.id:= RANDOM(),SELF:=LEFT) );


//sort it according to the random column. This, will essentially shuffle it.
dsshuffled:= sort(dswithrnd,id);

//now to remove that id again
// note -> most people actually don't remove the id term, but start using it for an sequential #.
dsshuffledids := project(dsshuffled, TRANSFORM(dsrecord,SELF:=LEFT));

//output the first ten, original
OUTPUT(CHOOSEN(ds,10),NAMED('default'));
//output the first ten, shuffled
OUTPUT(CHOOSEN(dsshuffledids,10),NAMED('shuffled'));