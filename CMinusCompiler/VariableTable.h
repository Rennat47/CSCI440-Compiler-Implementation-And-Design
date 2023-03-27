/*
 * Author(s): Tanner Smith, Jonathan Stephens
 * Last Updated: 11/11/2021
 * Description: A table that holds variable's of the cminus language
 */
#ifndef ASSIGNMENT_3_PARSER_VARIABLETABLE_H
#define ASSIGNMENT_3_PARSER_VARIABLETABLE_H
#include <map>
#include <string>
#include "Variable.h"
#include "treenode.h"
#include <iomanip>

using namespace std;

class VariableTable
        {
        private:
            map<string, Variable*> variables;
        public:
            VariableTable();

            VariableTable(treenode* node);

            void populateGlobal(treenode* n);

            void addVariable(Variable* var);

            void printTable();

            Variable* getVariable(string s);

            map<string, Variable*>* getVariables();

            int getTotalSize();

        };

#endif //ASSIGNMENT_3_PARSER_VARIABLETABLE_H
