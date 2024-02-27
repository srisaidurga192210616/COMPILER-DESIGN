#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX_IDENTIFIER_LENGTH 100

enum TokenType {
    IDENTIFIER,
    CONSTANT,
    OPERATOR
};

struct Token {
    enum TokenType type;
    char value[MAX_IDENTIFIER_LENGTH];
};

int isOperator(char c) {
    return c == '+' || c == '-' || c == '*' || c == '/' || c == '=' || c == '<' || c == '>' || c == '&' || c == '|';
}

void getToken(char *input, struct Token *token) {
    int i = 0;
    // Ignore leading whitespace
    while (isspace(input[i]))
        i++;

    // Check for identifier or keyword
    if (isalpha(input[i])) {
        int j = 0;
        while (isalnum(input[i]) || input[i] == '_') {
            token->value[j++] = input[i++];
        }
        token->value[j] = '\0';
        token->type = IDENTIFIER;
    }
    // Check for constant (assuming integer constant)
    else if (isdigit(input[i])) {
        int j = 0;
        while (isdigit(input[i])) {
            token->value[j++] = input[i++];
        }
        token->value[j] = '\0';
        token->type = CONSTANT;
    }
    // Check for operators
    else if (isOperator(input[i])) {
        token->value[0] = input[i];
        token->value[1] = '\0';
        token->type = OPERATOR;
        i++;
    }
    // Ignore comments
    else if (input[i] == '/' && input[i + 1] == '/') {
        // Skip until end of line or end of input
        while (input[i] != '\n' && input[i] != '\0')
            i++;
    }

    printf("Token: %s, Type: %d\n", token->value, token->type);
}

int main() {
    char input[] = "int main() {\n    // This is a comment\n    int a = 10;\n    float b = 3.14;\n    a = a + b;\n    return 0;\n}";
    struct Token token;

    int i = 0;
    while (input[i] != '\0') {
        getToken(&input[i], &token);
        // Move to the next non-whitespace character
        while (isspace(input[i]))
            i++;
        // Move to the next token
        i += strlen(token.value);
    }

    return 0;
}
