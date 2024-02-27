%option noyywrap

%{
#include <stdio.h>
%}

DIGIT       [0-9]
OPERATOR    [+\-*\/]

%%

{DIGIT}+    { printf("Number: %s\n", yytext); }
{OPERATOR}  { printf("Operator: %s\n", yytext); }
\n          ; // ignore newline characters
.           ; // ignore any other characters

%%

int main() {
    yylex();
    return 0;
}

