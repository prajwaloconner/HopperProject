%{
#include <stdio.h>
#include <stdlib.h>
#include "symbol_table.h"

int currentScope = 0; // Global scope for simplicity
%}

%%
"int"                                                 { printf("Keyword (Data type - int): %s\n", yytext); insertSymbol("int", "datatype", currentScope); }
"char"                                                { printf("Keyword (Data type - char): %s\n", yytext); insertSymbol("char", "datatype", currentScope); }
"float"                                               { printf("Keyword (Data type - float): %s\n", yytext); insertSymbol("float", "datatype", currentScope); }
"double"                                              { printf("Keyword (Data type - double): %s\n", yytext); insertSymbol("double", "datatype", currentScope); }
"void"|"bool"                                         { printf("Keyword (Data type): %s\n", yytext); insertSymbol(yytext, "datatype", currentScope); }

"if"|"else"|"for"|"while"|"do"                        { printf("Keyword (Control statement): %s\n", yytext); }
"switch"|"case"|"default"                             { printf("Keyword (Switch case): %s\n", yytext); }
"break"|"continue"|"return"|"exit"|"main"             { printf("Keyword: %s\n", yytext); insertSymbol(yytext, "keyword", currentScope); }
"true"|"false"                                        { printf("Keyword (Boolean literal): %s\n", yytext); insertSymbol(yytext, "boolean literal", currentScope); }
"class"|"import"|"static"                             { printf("Keyword: %s\n", yytext); insertSymbol(yytext, "keyword", currentScope); }
"struct"|"union"                                      { printf("Keyword (Composite type): %s\n", yytext); insertSymbol(yytext, "composite type", currentScope); }
"String"                                              { printf("Keyword (String type): %s\n", yytext); insertSymbol("String", "datatype", currentScope); }

"=="                                                  { printf("Relational operator (equal to): ==\n"); }
"!="                                                  { printf("Relational operator (not equal to): !=\n"); }
"<="                                                  { printf("Relational operator (less than or equal to): <=\n"); }
">="                                                  { printf("Relational operator (greater than or equal to): >=\n"); }
"<"                                                   { printf("Relational operator (less than): <\n"); }
">"                                                   { printf("Relational operator (greater than): >\n"); }

"+"|"-"|"*"|"/"|"%"                                   { printf("Arithmetic operator: %s\n", yytext); }
"&&"|"||"|"!"                                         { printf("Logical operator: %s\n", yytext); }
"\?"|":"                                              { printf("Ternary operator: %s\n", yytext); }
"="                                                   { printf("Assignment operator: %s\n", yytext); }
";"                                                   { printf("Semicolon: %s\n", yytext); }

"{"                                                   { printf("Left brace: %s\n", yytext); }
"}"                                                   { printf("Right brace: %s\n", yytext); }
"("                                                   { printf("Left parenthesis: %s\n", yytext); }
")"                                                   { printf("Right parenthesis: %s\n", yytext); }
"["                                                   { printf("Left bracket: %s (Array start)\n", yytext); }
"]"                                                   { printf("Right bracket: %s (Array end)\n", yytext); }

"hop\.out\.ln"                                        { printf("Print statement (newline): %s\n", yytext); }
"hop\.out"                                            { printf("Print statement: %s\n", yytext); }
"hopf"                                                { printf("Formatted print statement: %s\n", yytext); }
"hop\.in"                                             { printf("Input statement: %s\n", yytext); }

\"[^"]*\"                                             { printf("String literal: %s\n", yytext); }
\'[^']*\'                                             { printf("Character literal: %s\n", yytext); }

"new"                                                 { printf("Keyword (New instance): %s\n", yytext); insertSymbol("new", "keyword", currentScope); }
"this"                                                { printf("Keyword (Current instance): %s\n", yytext); insertSymbol("this", "keyword", currentScope); }

[0-9]+                                                { printf("Number: %s\n", yytext); }

[a-zA-Z_][a-zA-Z0-9_]*                                { printf("Identifier: %s\n", yytext); insertSymbol(yytext, "identifier", currentScope); }

[!@#$%^&*()-+=|;:,.<>?\\/[\]{}~`]                    { printf("Special character: %s\n", yytext); }

[ \t\n\r]+                                            { /* Skip whitespace */ }

.                                                     { printf("Unknown token: %s\n", yytext); }
%%

int main(int argc, char **argv) {
    yylex();
    printSymbolTable();
    freeSymbolTable();
    return 0;
}

int yywrap() {
    return 1;
}
