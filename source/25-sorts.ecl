SomeFile := DATASET([{'001','KC','G'}, {'003','KC','Z'}, 
                     {'005','KA','X'}, {'006','KB','A'}, 
                     {'002','KC','Z'}, {'007','KB','G'}, 
                     {'004','KC','C'}, {'008','KA','B'}
                    ],{STRING3 Id, String2 Value1, String1 Value2});

// sort ascending
SORT(somefile,id);

// sort descending
Sort(somefile,-id);