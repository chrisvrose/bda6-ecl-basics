export heart := MODULE
    export rec := RECORD
        unsigned age,
        unsigned sex,
        unsigned cp,
        unsigned trestbps,
        unsigned chol,
        unsigned fbs,
        unsigned restecg,
        unsigned thalach,
        unsigned exang,
        real oldpeak,
        unsigned slope,
        unsigned ca,
        unsigned thal,
        unsigned target
    END;
    export ds:= DATASET('~eclbasics::heart_failure.csv',rec,CSV(HEADING(1)));
END;