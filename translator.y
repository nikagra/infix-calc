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

    #include <stdio.h>
    #include <math.h>
    #include "global.h"
    extern void yyerror(char const *);
    extern int yylex(void);
%}

%token NUMBER LBRACE RBRACE EOL
%left PLUS MINUS 
%left MUL DIV 
%left NEG
%right POW

/* 
 *Grammar rules and actions follow.
 */
%%
input:
      /* empty */
    | input line
    ;
 
line:
      EOL
    | expr EOL      { printf(" = %g\n", $$); }
    | error EOL
    ;
     
expr:
      NUMBER                { $$ = $1; }
    | expr PLUS expr        { $$ = $1 + $3; }
    | expr MINUS expr       { $$ = $1 - $3; }
    | expr MUL expr         { $$ = $1 * $3; }
    | expr DIV expr         { $$ = $1 / $3; }
    | MINUS  expr %prec NEG { $$ = -$2; }
    | expr POW expr         { $$ = pow($1, $3); }
    | LBRACE expr RBRACE    { $$ = $2; }
    ;
%%
