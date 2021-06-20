//n!
n:= 12;

integerRec:= {integer factorialValue}; 
f0:=dataset([1],integerRec); //base condition: single value dataset initialized to one
integerRec factStep(dataset(integerRec) fact,integer cnt):= PROJECT(fact, 
        TRANSFORM(integerRec, 
               self.factorialValue:=left.factorialValue*cnt; )); //the iterating function operating on the dataset.

LOOP(f0,n,factStep(ROWS(LEFT) ,COUNTER)); //is 10 factorial