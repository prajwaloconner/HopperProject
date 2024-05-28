#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symbol_table.h"

Symbol *symbolTable = NULL;

Symbol* createSymbol(char *name, char *type, int scope) {
    Symbol *newSymbol = (Symbol*)malloc(sizeof(Symbol));
    newSymbol->name = strdup(name);
    newSymbol->type = strdup(type);
    newSymbol->scope = scope;
    newSymbol->next = NULL;
    return newSymbol;
}

void insertSymbol(char *name, char *type, int scope) {
    Symbol *newSymbol = createSymbol(name, type, scope);
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

void printSymbolTable() {
    Symbol *current = symbolTable;
    printf("Symbol Table:\n");
    printf("Name\tType\tScope\n");
    while (current != NULL) {
        printf("%s\t%s\t%d\n", current->name, current->type, current->scope);
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
