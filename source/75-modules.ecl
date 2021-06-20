import $.datasrc.modeg as someModule;

//cant output someModule.pvtVal though, it is shared not export
output([someModule.val,someModule.expVal,someModule.anotherVal,someModule.nested.val],NAMED('vals'));