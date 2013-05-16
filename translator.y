%{
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
