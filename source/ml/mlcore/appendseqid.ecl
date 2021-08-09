IMPORT ML_Core;

exampleRec := RECORD
    STRING name;
    STRING emailid;
    REAL marks;
    INTEGER studytime;
END;

exampleDs := DATASET('~example::example.csv', 
                    exampleRec, CSV(HEADING(1),
                    SEPARATOR(','),
                    TERMINATOR(['\n','\r\n','\n\r'])));

ML_Core.AppendSeqID(exampleDs, id, exampleDsID);
OUTPUT(ML_Core);