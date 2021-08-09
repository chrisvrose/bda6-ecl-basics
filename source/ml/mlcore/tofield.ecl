IMPORT ML_Core;

exampleRec := RECORD
    INTEGER id;
    REAL value;
END;

exampleDs := DATASET('~example::example.csv', 
                    exampleRec, CSV(HEADING(1),
                    SEPARATOR(','),
                    TERMINATOR(['\n','\r\n','\n\r'])));

ML_Core.ToField(exampleDs, exampleNF);
OUTPUT(exampleNF);