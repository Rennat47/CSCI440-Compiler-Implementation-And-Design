//
// Author(s): Tanner Smith, Jonathan Stephens
// Last Updated: 12/7/2021
//

#ifndef ASSIGNMENT_3_PARSER_CODEGENERATOR_H
#define ASSIGNMENT_3_PARSER_CODEGENERATOR_H

#include "treenode.h"
#include "FunctionTable.h"
#include "backfillLine.h"
#include <iostream>
#include <fstream>
#include <string>


using namespace std;
class CodeGenerator
{

private:
    treenode* root;
    VariableTable globalTable;
    FunctionTable functionTable;
    vector<backfillLine> backfillLines;
    int currentLine;
    string currentScope;
    const int PC_REG;
    const int GP_REG;
    const int FP_REG;
    const int SP_REG;

public:
    CodeGenerator(treenode *n);

    void generateCode(string fileName);

    void processDeclarations(treenode* n);

    void addROInstruction(int lineNum, string opcode, int r, int s, int t);

    void addROInstruction(int lineNum, string opcode, int r, int s, int t, string comment);

    void addRMInstruction(int lineNum, string opcode, int r, int d, int s);

    void addRMInstruction(int lineNum, string opcode, int r, int d, int s, string comment);

    void addComment(string comment);

    void backfill();

    string intToString(int n);

    int stringToInt(string s);

    void updateGlobals();

    void input(int r);

    void output(int r);

    void loadGlobal(treenode * n, int r);

    void storeGlobal(treenode * n, int r);

    void push(int r);

    void pop(int r);

    void additiveExpression(treenode* n);

    void comparisonExpression(treenode* n);

    void expressionStatement(treenode* n);

    void selectionStatement(treenode* n);

    void compoundStatement(treenode* n);

    void iterationStatement(treenode* n);

    void returnWithValue(treenode* n);

    void returnNoValue();

    void functionCall(string s);

    void loadVariable(treenode * n, int r);

    void storeVariable(treenode * n, int r);
};


#endif //ASSIGNMENT_3_PARSER_CODEGENERATOR_H
