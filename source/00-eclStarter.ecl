// this is reference code from ECL Playground, and it is not my code.
/*
    Example code - use without restriction.  
*/
Layout_Person := RECORD
  UNSIGNED1 PersonID;
  STRING15  FirstName;
  STRING25  LastName;
END;

allPeople := DATASET([ {1,'Fred','Smith'},
                       {2,'Joe','Blow'},
                       {3,'Jane','Smith'}],Layout_Person);

somePeople := allPeople(LastName = 'Smith');

//  Outputs  ---
OUTPUT(somePeople);