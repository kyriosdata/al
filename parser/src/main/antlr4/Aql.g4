//
// Copyright (c) 2017
//
// Fábio Nogueira de Lucena
// Fábrica de Software - Instituto de Informática (UFG)
//
// Creative Commons Attribution 4.0 International License.
//

grammar Aql;

aql : 'hello' ID ;

ID : [a-z]+;
WS : [ \t\r\n]+ -> skip ;
