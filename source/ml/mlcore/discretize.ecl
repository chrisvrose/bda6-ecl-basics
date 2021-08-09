IMPORT ML_Core;

exampleRec := RECORD
    INTEGER id;
    STRING name;
    STRING emailid;
    INTEGER age;
    BOOLEAN bookBought;
END;

exampleDs := DATASET('~example::example.csv', 
                    exampleRec, CSV(HEADING(1),
                    SEPARATOR(','),
                    TERMINATOR(['\n','\r\n','\n\r'])));

ML_Core.ToField(exampleDs, exampleNF);
OUTPUT(exampleNF);

// Discretization by Rounding values (1st Method)
rounded := ML_Core.Discretize.ByRounding(exampleNF);
OUTPUT(rounded, NAMED('ByRounding'));

// Discretization by Bucketing (2nd Method)
bucketed := ML_Core.Discretize.ByBucketing(exampleNF);
OUTPUT(bucketed, NAMED('ByBucketing'));

// Discretization by Tiling (3rd Method)
tiled := ML_Core.Discretize.ByTiling(exampleNF);
OUTPUT(tiled, NAMED('ByTiling'));