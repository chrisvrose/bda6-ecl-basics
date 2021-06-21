// importing the data
import $.datasrc.heart;
rec:=heart.rec;
ds:= heart.ds;

// get the number of rows in this dataset
// select COUNT(*) from heartds;
cnt:= COUNT(ds);
output(cnt,NAMED('cnt'));

// idea, get 3 people who have heart disease
// select * from heartds where target=1 limit 3;
targeted:= ds(target=1);
targetedLimited := CHOOSEN(ds,3);
OUTPUT(targetedLimited,named('limitedTarget'));

// idea - get the average age for people who have heart disease
// select avg(age) from heartds where target=1;
// here we see an interesting part of ECL come into picture, we can reuse definitions
avgAge := ave(targeted,age);
output(avgage,named('avgage'));

