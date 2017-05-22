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

// MAIN RULE (everything is governed by aql rule)
aql : lets? select from where? orderBy? EOF ;

// Section 1.4 Further discussion
lets    : (LET PARAMETER '=' ('"' path '"' | '\'' path '\'') '\n')+ ;

select  : SELECT  selectPath ;
from    : FROM    archetypeID ;
where   : WHERE   ID ;
orderBy : ORDERBY ID ;

archetypeID : '[' ID '-' ID '-' ID '.' ID '.v' NUMBER ']';

as         : AS ID ;
selectPath : path as? (',' selectPath)* ;

// Section 3.3 openEHR path syntax
path      : pathPart ('/' pathPart)* ;
pathPart  : ID codedTerm? ;
codedTerm : '[' ID ']' ;

// Identifier starts with a letter
ID : LETTER (LETTER | DIGIT | '_' )*;

// Section 3.5.3 Parameter syntax
PARAMETER : '$' ID ;

fragment LETTER : [a-zA-Z] ;
fragment DIGIT  : [0-9] ;

WHITESPACE : [ \t\r\n]+ -> skip ;

standardPredicate : leftHand OPERATOR rightHand ;
leftHand  : path ;
rightHand : path | OPERAND ;
OPERATOR : '>' | '<' | '>=' | '<=' | '=' | '!=' ;
OPERAND : CONSTANT | PARAMETER ;

// CONSTANTS
NUMBER   : DIGIT+ ;
BOOLEAN  : 'true' | 'false' ;
INTEGER  : '-'? NUMBER ;
REAL     : '-'? NUMBER '.' NUMBER ;
CONSTANT : '\'' (BOOLEAN | INTEGER | REAL) '\'' ;