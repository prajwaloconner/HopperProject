#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symbol_table.h"

Symbol *symbolTable = NULL;

Symbol* createSymbol(char *name, char *type, int scope, int value) {
    Symbol *newSymbol = (Symbol*)malloc(sizeof(Symbol));
    newSymbol->name = strdup(name);
    newSymbol->type = strdup(type);
    newSymbol->scope = scope;
    newSymbol->value = value;
    newSymbol->next = NULL;
    return newSymbol;
}

void insertSymbol(char *name, char *type, int scope, int value) {
    Symbol *existingSymbol = findSymbol(name);
    if (existingSymbol) {
        printf("Symbol %s already exists. Updating value.\n", name);
        existingSymbol->value = value;
        return;
    }
    Symbol *newSymbol = createSymbol(name, type, scope, value);
    newSymbol->next = symbolTable;
    symbolTable = newSymbol;
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

void updateSymbolValue(char *name, int value) {
    Symbol *symbol = findSymbol(name);
    if (symbol) {
        symbol->value = value;
    } else {
        printf("Symbol %s not found.\n", name);
    }
}

void printSymbolTable() {
    Symbol *current = symbolTable;
    printf("Symbol Table:\n");
    printf("Name\tType\tScope\tValue\n");
    while (current != NULL) {
        printf("%s\t%s\t%d\t%d\n", current->name, current->type, current->scope, current->value);
        current = current->next;
    }
}

void freeSymbolTable() {
    Symbol *current = symbolTable;
    Symbol *nextSymbol;
    while (current != NULL) {
        nextSymbol = current->next;
        free(current->name);
        free(current->type);
        free(current);
        current = nextSymbol;
    }
}
