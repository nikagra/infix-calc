/*
 *
 */

%{
#include <stdlib.h>
#include <stdio.h>
#include "global.h"
#include "translator.hpp"
%}

%x IN_COMMENT

%%
<INITIAL>{
    [ \t]
    "#"                     BEGIN(IN_COMMENT);
    [0-9]+(\.[0-9]+)?       yylval = atof(yytext); return NUMBER;
    "+"                     return PLUS;
    "-"                     return MINUS;
    "*"                     return MUL;
    "/"                     return DIV;
    "^"                     return POW;
    "("                     return LBRACE;
    ")"                     return RBRACE;
    \n                      return EOL;
    .         
}
<IN_COMMENT>{
    \n                      ECHO; BEGIN(INITIAL);
}           
%%
