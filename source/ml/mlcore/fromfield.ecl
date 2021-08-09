IMPORT ML_Core;

exampleRec := RECORD
    INTEGER id;
    STRING name;
    STRING emailid;
    REAL marks;
    INTEGER studytime;
END;

exampleDs := DATASET('~example::example.csv', 
                    exampleRec, CSV(HEADING(1),
                    SEPARATOR(','),
                    TERMINATOR(['\n','\r\n','\n\r'])));

ML_Core.ToField(exampleDs, exampleNF);
OUTPUT(exampleNF);

ML_Core.FromField(exampleNF, exampleRec, exampleDsOut);
OUTPUT(exampleDsOut);