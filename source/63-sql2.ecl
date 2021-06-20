// importing the data
import $.datasrc.heart;
rec:=heart.rec;
ds:= heart.ds;

// performing vertical slices using TABLE
// select age, sex, chol,target from heartds limit 15 order by age;
subsec := TABLE(ds,{age,sex,chol,target});
subsecSorted := sort(subsec,age);
output(subsecSorted[1..15],named('vslice'));

// select COUNT(*),age from heartds group by age where target=1;
// args:
// 1. input dataset
// 2. what is the record struct, the aggregate structures accept the group argument
// 3. the value to group by
cnt:= TABLE(ds(target=1),{cnt:=COUNT(GROUP),age},age);
output(cnt,NAMED('cnt'));


// select age,trestbps,target from heartds order by trestbps desc limit 5;
tresttable:= TABLE(ds,{age,trestbps,target});
// note how `-' is used to sort by descending order
tresttableSorted := SORT(tresttable,-trestbps);
OUTPUT(tresttableSorted[..5],NAMED('tts'));


