/*
 * Author(s): Tanner Smith, Jonathan Stephens
 * Last Updated: 11/11/2021
 * Description: A table that holds the functions of a cminus program
 */

#ifndef ASSIGNMENT_3_PARSER_FUNCTIONTABLE_H
#define ASSIGNMENT_3_PARSER_FUNCTIONTABLE_H
#include <map>
#include <string>
#include "Function.h"

using namespace std;

class FunctionTable
{
private:
    map<string, Function*> functions;
public:
    FunctionTable();

    FunctionTable(treenode* n);

    void generateFunctionTable(treenode* node, string scope);

    void addFunction(Function* func);

    void printTable();

    Function* getFunction(string funcName);

};


#endif //ASSIGNMENT_3_PARSER_FUNCTIONTABLE_H
