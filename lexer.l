%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symbol_table.h"

int currentScope = 0; // Global scope for simplicity
%}

%option noyywrap

%union {
    int ival;
    char cval;
    char *sval;
}

%token <sval> IDENTIFIER
%token <ival> NUMBER
%token <cval> CHARACTER
%token <sval> STRING

%token INT CHAR FLOAT DOUBLE VOID BOOL
%token IF ELSE FOR WHILE DO SWITCH CASE DEFAULT BREAK CONTINUE RETURN EXIT MAIN TRUE FALSE CLASS IMPORT STATIC STRUCT UNION STRING_KEY NEW THIS
%token EQ NEQ LEQ GEQ LT GT
%token PLUS MINUS MUL DIV MOD AND OR NOT ASSIGN SEMICOLON
%token LBRACE RBRACE LPAREN RPAREN LBRACKET RBRACKET

%%
"int"          { return INT; }
"char"         { return CHAR; }
"float"        { return FLOAT; }
"double"       { return DOUBLE; }
"void"         { return VOID; }
"bool"         { return BOOL; }

"if"           { return IF; }
"else"         { return ELSE; }
"for"          { return FOR; }
"while"        { return WHILE; }
"do"           { return DO; }
"switch"       { return SWITCH; }
"case"         { return CASE; }
"default"      { return DEFAULT; }
"break"        { return BREAK; }
"continue"     { return CONTINUE; }
"return"       { return RETURN; }
"exit"         { return EXIT; }
"main"         { return MAIN; }
"true"         { return TRUE; }
"false"        { return FALSE; }
"class"        { return CLASS; }
"import"       { return IMPORT; }
"static"       { return STATIC; }
"struct"       { return STRUCT; }
"union"        { return UNION; }
"String"       { return STRING_KEY; }
"new"          { return NEW; }
"this"         { return THIS; }

"=="           { return EQ; }
"!="           { return NEQ; }
"<="           { return LEQ; }
">="           { return GEQ; }
"<"            { return LT; }
">"            { return GT; }

"+"            { return PLUS; }
"-"            { return MINUS; }
"*"            { return MUL; }
"/"            { return DIV; }
"%"            { return MOD; }
"&&"           { return AND; }
"||"           { return OR; }
"!"            { return NOT; }
"="            { return ASSIGN; }
";"            { return SEMICOLON; }

"{"            { return LBRACE; }
"}"            { return RBRACE; }
"("            { return LPAREN; }
")"            { return RPAREN; }
"["            { return LBRACKET; }
"]"            { return RBRACKET; }

\"[^\"]*\"     { yylval.sval = strdup(yytext); return STRING; }
\'[^\']\'      { yylval.cval = yytext[1]; return CHARACTER; }

[0-9]+         { yylval.ival = atoi(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.sval = strdup(yytext); return IDENTIFIER; }

[ \t\n\r]+     { /* Skip whitespace */ }
.              { printf("Unknown token: %s\n", yytext); }
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
