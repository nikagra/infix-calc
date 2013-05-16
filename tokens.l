%{
/* 
  This file is part of rpn-calc:
  Reverse Polish notation (RPN) calculator written in C++ using flex and bison. 
  Copyright (C) 2013 nikagra <nikagra@gmail.com>

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program. If not, see <http://www.gnu.org/licenses/>.
*/

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
