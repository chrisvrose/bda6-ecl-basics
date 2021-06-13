import std;

// This is a record
myDataLayout := RECORD
    DECIMAL5_3 YearsExperience,
    DECIMAL8_2 Salary,
END;

// mydata represents a way to read the dataset
// the first argument is the location of the data
// the second argument is the record layout
// the third argument is the file type (optional).
// we are using a csv file, with one row as header
mydata:= dataset('~eclbasics::salary_data.csv',mydatalayout,CSV(HEADING(1)));

// count the number of rows in the dataset
// Note: there's a hidden optimization. 
// If this is the output, then the rowcount will be fetched from the data store location.
// That option is much more efficient as each data store has a rough idea of the row count of each dataset.
dataCount:= COUNT(mydata);

minSalary:= MIN(mydata,salary);

maxSalary:= max(mydata,salary);

avgYears := ave(mydata,yearsexperience);

// one-indexed, not zero
firstEntry:= myData[1];

// outputs --
OUTPUT(datacount);
OUTPUT(avgYears, NAMED('avg'));
OUTPUT(minSalary,NAMED('min'));
OUTPUT(maxSalary,NAMED('max'));
OUTPUT(firstEntry,NAMED('first'));

// trying to view them at the same time
// this won't work, this will just get the sum, which is not as useful
OUTPUT(avgYears+minSalary+maxSalary,named('sum'));
// this packs it up as a collection of tuples
OUTPUT([avgYears]+[minSalary]+[maxSalary],NAMED('set'));

