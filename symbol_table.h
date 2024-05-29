#ifndef SYMBOL_TABLE_H
#define SYMBOL_TABLE_H

typedef struct Symbol {
    char *name;
    char *type;
    int scope;
    int value; // Store the value of the variable
    struct Symbol *next;
} Symbol;

Symbol* createSymbol(char *name, char *type, int scope, int value);
void insertSymbol(char *name, char *type, int scope, int value);
Symbol* findSymbol(char *name);
void updateSymbolValue(char *name, int value);
void printSymbolTable();
void freeSymbolTable();

#endif // SYMBOL_TABLE_H
