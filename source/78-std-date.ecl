IMPORT STD;



//today's date
D1 := STD.Date.Today();

// what is tomorrow?
// args: <original>,[delta years,[,[delta months,[[delta days]]]]]
d2:= STD.Date.AdjustDate(d1,0,0,1);

// integer representing day of the week -> how to get string?
todaydowti:=STD.Date.DayOfWeek(d1);
tomdowti:= STD.Date.DayOfWeek(d2);

//can use map - let's write a function with one argument
dayofweekS(Std.date.date_t d):= FUNCTION
    r:=MAP(d=1  => 'SUNDAY',
        d=2 => 'MONDAY',
        d=3 => 'TUESDAY',
        d=4 => 'WEDNESDAY',
        d=5 => 'THURSDAY',
        d=6 => 'FRIDAY',
        d=7 => 'SATURDAY','?');
    return r;
END;

OUTPUT(d1);
// todaydowti;
todaydow:=dayofWeekS(todaydowti);
tomdow:=dayofWeekS(tomdowti);
//which day of the week is tomorrow?
OUTPUT([todaydow,tomdow],NAMED('today_tomorrow'));