/* 
  This file is part of infix-calc:
  Infix calculator written in C++ using flex and bison. 
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
