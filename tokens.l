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
    "#"                     ECHO; BEGIN(IN_COMMENT);
    [0-9]+(\.[0-9]+)?       ECHO; yylval = atof(yytext); return NUMBER;
    "+"                     ECHO; return PLUS;
    "-"                     ECHO; return MINUS;
    "*"                     ECHO; return MUL;
    "/"                     ECHO; return DIV;
    "^"                     ECHO; return POW;
    "("                     ECHO; return LBRACE;
    ")"                     ECHO; return RBRACE;
    \n                      ECHO; return EOL;
    .         
}
<IN_COMMENT>{
    \n                      ECHO; BEGIN(INITIAL);
}           
%%
