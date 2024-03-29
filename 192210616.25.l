%{
#include <stdio.h>
#include <string.h>

int word_count = 0;
char target_word[100];

void count_word(char *word) {
    if (strcmp(word, target_word) == 0) {
        word_count++;
    }
}

int yywrap() {
    return 1;
}
%}

%%
[a-zA-Z]+    { count_word(yytext); }
\n           { return 0; }
.            ;
%%

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Usage: %s <target_word>\n", argv[0]);
        return 1;
    }

    strcpy(target_word, argv[1]);

    yylex();

    printf("Frequency of \"%s\" is: %d\n", target_word, word_count);

    return 0;
}
