rec1:={integer uid,string name, string email};
rec2:={integer iid,string itemname,integer qty,decimal5_2 price,integer purchasedBy};
// cust details
ds1:=DATASET([{1,'Akshay','akshay@example.com'},
            {2,'Michael','michaela@example.com'},
            {3,'Carl','carlbd@example.com'},
            {4,'Cera','ceralk@example.com'}],
            rec1);

// purchased items
ds2:= DATASET([{1,'Carrots',2,1.2,1},{1,'Carrots',4,1.12,3},{2,'Cabbages',20,0.63,2}],rec2);

// select email,iid,itemname,price*quantity as amt from ds1 join ds2 on ds1.uid=ds2.purchasedBy;
jds := JOIN(ds1,ds2,LEFT.uid=RIGHT.purchasedBy);
jdo := TABLE(jds,{email,iid,itemname,amt:=price*qty});
//output
jdo;
