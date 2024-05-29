#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symbol_table.h"

Symbol *symbolTable = NULL;

Symbol* createSymbol(char *name, DataType type, int scope, void *value) {
    Symbol *newSymbol = (Symbol*)malloc(sizeof(Symbol));
    newSymbol->name = strdup(name);
    newSymbol->type = type;
    newSymbol->scope = scope;

    switch (type) {
        case INT_TYPE:
            newSymbol->value.ival = *((int*)value);
            break;
        case CHAR_TYPE:
            newSymbol->value.cval = *((char*)value);
            break;
        case STRING_TYPE:
            newSymbol->value.sval = strdup((char*)value);
            break;
        case FLOAT_TYPE:
            newSymbol->value.fval = *((float*)value);
            break;
    }

    newSymbol->next = symbolTable;
    symbolTable = newSymbol;

    return newSymbol;
}

void insertSymbol(char *name, DataType type, int scope, void *value) {
    Symbol *existingSymbol = findSymbol(name);
    if (existingSymbol && existingSymbol->scope == scope) {
        updateSymbolValue(name, type, value);
    } else {
        createSymbol(name, type, scope, value);
    }
}

Symbol* findSymbol(char *name) {
    Symbol *current = symbolTable;
    while (current != NULL) {
        if (strcmp(current->name, name) == 0) {
            return current;
        }
        current = current->next;
    }
    return NULL;
}

void updateSymbolValue(char *name, DataType type, void *value) {
    Symbol *symbol = findSymbol(name);
    if (symbol) {
        symbol->type = type;
        switch (type) {
            case INT_TYPE:
                symbol->value.ival = *((int*)value);
                break;
            case CHAR_TYPE:
                symbol->value.cval = *((char*)value);
                break;
            case STRING_TYPE:
                free(symbol->value.sval);
                symbol->value.sval = strdup((char*)value);
                break;
            case FLOAT_TYPE:
                symbol->value.fval = *((float*)value);
                break;
        }
    }
}

void printSymbolTable() {
    Symbol *current = symbolTable;
    while (current != NULL) {
        printf("Name: %s, Scope: %d, Type: ", current->name, current->scope);
        switch (current->type) {
            case INT_TYPE:
                printf("INT, Value: %d\n", current->value.ival);
                break;
            case CHAR_TYPE:
                printf("CHAR, Value: %c\n", current->value.cval);
                break;
            case STRING_TYPE:
                printf("STRING, Value: %s\n", current->value.sval);
                break;
            case FLOAT_TYPE:
                printf("FLOAT, Value: %f\n", current->value.fval);
                break;
        }
        current = current->next;
    }
}

void freeSymbolTable() {
    Symbol *current = symbolTable;
    while (current != NULL) {
        Symbol *next = current->next;
        free(current->name);
        if (current->type == STRING_TYPE) {
            free(current->value.sval);
        }
        free(current);
        current = next;
    }
    symbolTable = NULL;
}
