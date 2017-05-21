//
// Copyright (c) 2017
//
// Fábio Nogueira de Lucena
// Fábrica de Software - Instituto de Informática (UFG)
//
// Creative Commons Attribution 4.0 International License.
//

// ISSUES
// - upper and lower cases are not ignored (mixed)

grammar Aql;

// Reserved words
AND             : 'AND' ;
AS              : 'AS' ;
CONTAINS        : 'CONTAINS' ;
CURRENTDATE     : 'current-date' ;
CURRENTDATETIME : 'current-date-time' ;
EXISTS          : 'exists' ;
FROM            : 'FROM' ;
IN              : 'in' ;
LET             : 'LET' ;
MATCHES         : 'matches' ;
MAX             : 'max' ;
NOTIN           : 'not in' ;
NOW             : 'now' ;
OR              : 'OR' ;
ORDERBY         : 'ORDER BY' ;
SELECT          : 'SELECT' ;
TIMEWINDOW      : 'TIMEWINDOW' ;
TOP             : 'TOP' ;
WHERE           : 'WHERE' ;

fragment INTERVAL        : '|' ;
fragment DOUBLESTR       : '"' ;
fragment SINGLESTR       : '\'' ;

aql : lets? select from where? orderBy? EOF ;

// Section 1.4 Further discussion
lets    : (LET assignment '\n')+ ;

select  : SELECT  selectPath ;
from    : FROM    VARIABLE ;
where   : WHERE   VARIABLE ;
orderBy : ORDERBY VARIABLE ;

assignment : PARAMETER '=' path ;

as         : AS VARIABLE ;
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