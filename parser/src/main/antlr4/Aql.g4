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
from    : 'FROM'     VARIABLE ;
where   : 'WHERE'    VARIABLE ;
orderBy : 'ORDER BY' VARIABLE ;

as : 'AS' VARIABLE ;
selectPath : path as? (',' selectPath)* ;

// Section 3.3 openEHR path syntax
path      : pathPart ('/' pathPart)* ;
pathPart  : VARIABLE predicate? ;
predicate : '[' VARIABLE ']' ;

VARIABLE : LETTER (LETTER | DIGIT | '_' )*;

// Section 3.5.3 Parameter syntax
PARAMETER : '$' VARIABLE ;

LETTER : [a-zA-Z] ;
DIGIT  : [0-9] ;

WHITESPACE : [ \t\r\n]+ -> skip ;

standardPredicate : leftHand OPERATOR rightHand ;
leftHand  : path ;
rightHand : path | OPERAND ;
OPERATOR : '>' | '<' | '>=' | '<=' | '=' | '!=' ;
OPERAND : CONSTANT | PARAMETER ;

// CONSTANTS
BOOLEAN  : 'true' | 'false' ;
INTEGER  : '-'? DIGIT+ ;
REAL     : '-'? DIGIT+ '.' DIGIT+ ;
CONSTANT : '\'' (BOOLEAN | INTEGER | REAL) '\'' ;