// importing the data
import $.datasrc.heart;
rec:=heart.rec;
ds:= heart.ds;

// select COUNT(*) from heartds;
cnt:= COUNT(ds);
output(cnt,NAMED('cnt'));


// select * from heartds where target=1 limit 3;
targeted:= ds(target=1);
targetedLimited := CHOOSEN(ds,3);
OUTPUT(targetedLimited,named('limitedTarget'));

// select avg(age) from heartds where target=1;
// here we see an interesting part of ECL come into picture, we can reuse definitions
avgAge := ave(targeted,age);
output(avgage,named('avgage'));

