%option noyywrap

%{
#include <stdio.h>
int whitespace_count = 0;
int newline_count = 0;
%}

%%

[ \t]      { whitespace_count++; }
\n         { newline_count++; }

.          ; // ignore any other characters

%%

int main() {
    yylex();
    printf("Number of whitespace characters: %d\n", whitespace_count);
    printf("Number of newline characters: %d\n", newline_count);
    return 0;
}
