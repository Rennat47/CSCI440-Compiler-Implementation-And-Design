/*
 * Author(s): Tanner Smith, Jonathan Stephens
 * Last Updated: 12/7/2021
 * Description: The main function is stored here
 */
#include "common.h"
#include "Parser.hpp"
#include "stdio.h"
#include "FunctionTable.h"
#include "CodeGenerator.h"
#include "iostream"

extern FILE * yyin;
extern treenode * root;

int main(int argc, char *argv[])
{
//    cout << "starting" << endl;
    if ( argc > 1 )
    {
        yyin = fopen( argv[1], "r" );
    }
    else
    {
        cout << "Reading from standard input." << endl;
        yyin = stdin;
    }
    cout << "before yyparse" << endl;
    yyparse();
    cout << "after yyparse" << endl;

    root->preorder_print(); //Uncomment to print the parse tree

//    VariableTable globalVars = VariableTable(root);
//    cout << "Successfully generated global var table" << endl;
//
//    FunctionTable functionTable = FunctionTable(root);
//    cout << "Successfully generated function table" << endl;
//
//    cout << "Printing Global Table" << endl;
//    globalVars.printTable();
//
//    cout << "Printing Function Table" << endl;
//    functionTable.printTable();

    CodeGenerator codeGen = CodeGenerator(root);
    codeGen.generateCode(argv[1]);
    return 0;
}
