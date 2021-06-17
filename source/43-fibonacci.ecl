fibRec:={integer predValue, integer curValue};

//base conditions
fib0:=dataset([{0,1}],fibRec); 
// using these two, create a new one
// here, this transformation is repeatedly applied to the dataset
fibRec fibonacciStep(DATASET(fibRec) fib):=PROJECT(fib,
      TRANSFORM(fibRec,
            self.curValue:=left.curValue+left.predValue;
            self.predValue:=left.curValue; 
      ));


stepCount := 6;
// loop 6 times
LOOP(fib0,stepCount,fibonacciStep(ROWS(LEFT))); //sixth fibonacci pair subsequent to base pair