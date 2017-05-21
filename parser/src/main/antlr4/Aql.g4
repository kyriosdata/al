//
// Copyright (c) 2017
//
// Fábio Nogueira de Lucena
// Fábrica de Software - Instituto de Informática (UFG)
//
// Creative Commons Attribution 4.0 International License.
//

grammar Aql;

aql : select from where? orderBy? EOF ;

select  : 'SELECT'   selectPath ;
from    : 'FROM'     variable ;
where   : 'WHERE'    variable ;
orderBy : 'ORDER BY' variable ;

as : 'AS' variable ;
selectPath : path as? (',' selectPath)* ;

path      : pathPart ('/' pathPart)* ;
pathPart  : variable predicate? ;
predicate : '[' variable ']' ;

variable : LETTER+ (LETTER | DIGIT | '_' )*;

LETTER : 'a'..'z'|'A'..'Z' ;
DIGIT  : '0'..'9' ;

WS : [ \t\r\n]+ -> skip ;
