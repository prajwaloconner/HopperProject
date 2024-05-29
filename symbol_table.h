#ifndef SYMBOL_TABLE_H
#define SYMBOL_TABLE_H

typedef enum { INT_TYPE, CHAR_TYPE, STRING_TYPE, FLOAT_TYPE } DataType;

typedef struct Symbol {
    char *name;
    DataType type;
    int scope;
    union {
        int ival;
        char cval;
        char *sval;
        float fval;
    } value;
    struct Symbol *next;
} Symbol;

Symbol* createSymbol(char *name, DataType type, int scope, void *value);
void insertSymbol(char *name, DataType type, int scope, void *value);
Symbol* findSymbol(char *name);
void updateSymbolValue(char *name, DataType type, void *value);
void printSymbolTable();
void freeSymbolTable();

#endif // SYMBOL_TABLE_H

