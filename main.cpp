#include <stdio.h>
extern int yyparse();
extern FILE* yyin;

int main(int argc, char **argv)
{
        ++argv; --argc;
        if (argc == 0)
        {
                yyin = stdin;
                yyparse();
        } 
        else 
                while (argc-- > 0)
                {
                        yyin = fopen(argv[0], "r");
                        if (!yyin)
                        {
                                printf("Can't open file %s", argv[0]);
                                return 1;
                        }
                        yyparse();
                        ++argv;
                }
        return 0;
}

void yyerror(const char *s)
{
        printf("ERROR: %s\n", s);
}
