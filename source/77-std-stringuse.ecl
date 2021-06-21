import std;

word:= 'ap';

rec:= {integer srcid,string words};
recsrc:={integer srcid,string srcname};
recNorm:={integer srcid,string word};
s:= dataset([
    {1,'accelerator illuminating impose prussia'},
    {2,'lagrasta californiastyle tap cranked recognised  '},
    {2,'contemplate guardino commodities sensed seam    cap '},
    {3,'inaccurately noonan carolina freestyle waning   superconductor      map'},
    {1,'    api  joanne cpi armstrong divest controlling  superconductor  '}
],rec);

// add some oldlen and newlen rows to understand the change in length
trimmedsStats:= PROJECT(s,TRANSFORM({rec,integer oldlen,integer newlen}, self.words:=trim(left.words),self.oldlen:=length(left.words),self.newlen:=length(self.words),SELF := LEFT));

// Whereas the previous removes spaces from the ends,
// this function CleanSpaces removes multiple adjacent occurences of spaces and tabs (and makes them 1 space)
trimmeds:= project(s,TRANSFORM(rec, self.words:=STD.str.CleanSpaces(left.words),SELF := LEFT));


// push wordcounts
trimmedsCounts:= PROJECT(trimmeds, TRANSFORM({rec,integer wc},self.wc:=STD.Str.CountWords(left.words,' '),self:=left));

//use this wordcount to normalize and convert each row which is an 'array' of elements into individual rows
normedWords:= NORMALIZE(trimmedsCounts,LEFT.wc,TRANSFORM(recnorm, self.word:=std.str.splitwords(left.words,' ')[COUNTER],SELF := LEFT));

//outputs
OUTPUT(trimmedsStats,NAMED('trimmedStats'));
OUTPUT(trimmedsCounts,NAMED('lengthCounts'));
OUTPUT(normedWords,NAMED('normed'));


editDistances :=PROJECT(normedWords,TRANSFORM({INTEGER editDistance,string word},self.editDistance:=std.str.editdistance(word,left.word),self.word:=left.word));
OUTPUT(editDistances,NAMED('editDistances'));
//calc the minimum
minEditDistance:= min(editDistances,editDistance);
//which of these words were part of that?
minWords:= editDistances(editDistance=minEditDistance);

OUTPUT(minWords,NAMED('minEdits'));