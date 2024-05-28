#ifndef SYMBOL_TABLE_H
#define SYMBOL_TABLE_H

typedef struct Symbol {
    char *name;
    char *type;
    int scope;
    struct Symbol *next;
} Symbol;

Symbol* createSymbol(char *name, char *type, int scope);
void insertSymbol(char *name, char *type, int scope);
Symbol* findSymbol(char *name);
void printSymbolTable();
void freeSymbolTable();

#endif // SYMBOL_TABLE_H
