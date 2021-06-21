IMPORT Visualizer;
ds := DATASET([ {'English', 56},
 {'History', 17},
 {'Geography', 70},
 {'Chemistry', 32},
 {'Bioligy', 62},
 {'Physics', 46},
 {'Math', 98}],
 {STRING subject, INTEGER4 mks});


data_example := OUTPUT(ds, NAMED('mychart'));
data_example;

//wordcloud
Visualizer.TwoD.WordCloud('WordCloud',, 'mychart');
// bar
Visualizer.MultiD.Bar('Bar',,'mychart');
// pie
Visualizer.TwoD.Pie('Pie',,'mychart');