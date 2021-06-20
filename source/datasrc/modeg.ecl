export modeg := MODULE

  EXPORT val := 1;
  someDefValue := 2;
  export expVal:= someDefValue+val; // will receive 3
  //default values loses scope after a shared/export - we can reassign
  someDefValue:= 1.23;
  export anotherVal := someDefValue+val; // 2.23
  shared pvtVal := anotherVal+'';
  EXPORT nested := MODULE // nested module
      export val := 4;
  END;
END;
