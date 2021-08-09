NormRec := RECORD
  STRING20  thename;
  STRING20  addr;
END;
NamesRec := RECORD
  UNSIGNED1  numRows;
  STRING20  thename; 
  STRING20  addr1 := '';
  STRING20  addr2 := '';
  STRING20  addr3 := '';
  STRING20  addr4 := '';
END;
NamesTable := DATASET([ {0,'Kevin'},{0,'Liz'},{0,'Mr Nobody'},
                        {0,'Anywhere'}], NamesRec);
NormAddrs := DATASET([{'Kevin','10 Malt Lane'},
                      {'Liz','10 Malt Lane'},
                      {'Liz','3 The cottages'},
                      {'Anywhere','Here'},
                      {'Anywhere','There'},
                      {'Anywhere','Near'},
                      {'Anywhere','Far'}],NormRec);
NamesRec DeNormThem(NamesRec L, NormRec R, INTEGER C) := TRANSFORM
    SELF.NumRows := C;
    SELF.addr1 := IF (C=1, R.addr, L.addr1);
    SELF.addr2 := IF (C=2, R.addr, L.addr2);
    SELF.addr3 := IF (C=3, R.addr, L.addr3);
    SELF.addr4 := IF (C=4, R.addr, L.addr4);
    SELF := L;
END;
DeNormedRecs := DENORMALIZE(NamesTable, NormAddrs,
                            LEFT.thename = RIGHT.thename,
                            DeNormThem(LEFT,RIGHT,COUNTER));
OUTPUT(DeNormedRecs);