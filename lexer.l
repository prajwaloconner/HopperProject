%{
#include <stdio.h>
#include <stdlib.h>
#include "symbol_table.h"

int currentScope = 0; // Global scope for simplicity
int currentValue = 0; // To store the value of the variable being processed
%}

%option noyywrap

%%
"int"          { printf("Keyword (Data type - int): %s\n", yytext); }
"char"         { printf("Keyword (Data type - char): %s\n", yytext); }
"float"        { printf("Keyword (Data type - float): %s\n", yytext); }
"double"       { printf("Keyword (Data type - double): %s\n", yytext); }
"void"|"bool"  { printf("Keyword (Data type): %s\n", yytext); }

"if"|"else"|"for"|"while"|"do" { printf("Keyword (Control statement): %s\n", yytext); }
"switch"|"case"|"default"      { printf("Keyword (Switch case): %s\n", yytext); }
"break"|"continue"|"return"|"exit"|"main" { printf("Keyword: %s\n", yytext); }
"true"|"false" { printf("Keyword (Boolean literal): %s\n", yytext); }
"class"|"import"|"static" { printf("Keyword: %s\n", yytext); }
"struct"|"union" { printf("Keyword (Composite type): %s\n", yytext); }
"String" { printf("Keyword (String type): %s\n", yytext); }

"==" { printf("Relational operator (equal to): ==\n"); }
"!=" { printf("Relational operator (not equal to): !=\n"); }
"<=" { printf("Relational operator (less than or equal to): <=\n"); }
">=" { printf("Relational operator (greater than or equal to): >=\n"); }
"<"  { printf("Relational operator (less than): <\n"); }
">"  { printf("Relational operator (greater than): >\n"); }

"+"|"-"|"*"|"/"|"%" { printf("Arithmetic operator: %s\n", yytext); }
"&&"|"||"|"!" { printf("Logical operator: %s\n", yytext); }
"\?"|":" { printf("Ternary operator: %s\n", yytext); }
"=" { printf("Assignment operator: %s\n", yytext); currentValue = 0; }

";" { printf("Semicolon: %s\n", yytext); }

"{" { printf("Left brace: %s\n", yytext); currentScope++; }
"}" { printf("Right brace: %s\n", yytext); currentScope--; }
"(" { printf("Left parenthesis: %s\n", yytext); }
")" { printf("Right parenthesis: %s\n", yytext); }
"[" { printf("Left bracket: %s (Array start)\n", yytext); }
"]" { printf("Right bracket: %s (Array end)\n", yytext); }

"hop\.out\.ln" { printf("Print statement (newline): %s\n", yytext); }
"hop\.out" { printf("Print statement: %s\n", yytext); }
"hopf" { printf("Formatted print statement: %s\n", yytext); }
"hop\.in" { printf("Input statement: %s\n", yytext); }

\"[^\"]*\" { printf("String literal: %s\n", yytext); }
\'[^\']*\' { printf("Character literal: %s\n", yytext); }

"new" { printf("Keyword (New instance): %s\n", yytext); }
"this" { printf("Keyword (Current instance): %s\n", yytext); }

[0-9]+ {
    currentValue = atoi(yytext);
    printf("Number: %s\n", yytext);
}

[a-zA-Z_][a-zA-Z0-9_]* {
    printf("Identifier: %s\n", yytext);
    // Check if the identifier is being assigned a value
    if (currentValue != 0) {
        insertSymbol(yytext, "identifier", currentScope, currentValue);
        currentValue = 0;
    } else {
        Symbol *symbol = findSymbol(yytext);
        if (symbol) {
            // Increment or update value
            printf("Updating value of %s\n", yytext);
            symbol->value++;
        } else {
            insertSymbol(yytext, "identifier", currentScope, 0);
        }
    }
}

[ \t\n\r]+ { /* Skip whitespace */ }

. { printf("Unknown token: %s\n", yytext); }
%%

int main(int argc, char **argv) {
    yylex();
    printSymbolTable();
    freeSymbolTable();
    return 0;
}
