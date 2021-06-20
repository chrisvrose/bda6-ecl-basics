//Form 1 example
NamesRec := RECORD
    UNSIGNED1 numrows;
    STRING20 name;
    // some default arguments if not present
    STRING20 attr1 := '';
    STRING20 attr2 := '';
    STRING20 attr3 := '';
END;

// inline a dataset
NamesTable := DATASET([ {2,'Abraham','Swimming','Football'},
                {2,'Liz','Tennis','Basketball'},
                {0,'Akshay'},
                {3,'Michael','Coding','Cricket','Near'}],
            NamesRec);

// the output recordset
childRec := RECORD
    UNSIGNED1 numrows;
    STRING20 name;
    STRING20 attr;
END;

// transform function
childRec NormIt(NamesRec L, INTEGER C) := TRANSFORM
    // inherit everything usually by default
    SELF := L;
    // pick according to which C from the argument
    SELF.attr := CHOOSE(C, L.attr1, L.attr2, L.attr3);
END;

// arguments are
// 1. input table
// 2. the number of child records for a given record
// 3. the transform
NormAddrs := NORMALIZE(namesTable,LEFT.numRows,NormIt(LEFT,COUNTER));
OUTPUT(NormAddrs);