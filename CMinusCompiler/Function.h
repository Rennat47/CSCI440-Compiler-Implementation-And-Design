/*
 * Author(s): Tanner Smith, Jonathan Stephens
 * Last Updated: 11/11/2021
 * Description: A Class to represent a function, and it's components from the cminus language
 */
#ifndef ASSIGNMENT_3_PARSER_FUNCTION_H
#define ASSIGNMENT_3_PARSER_FUNCTION_H
#include <map>
#include <string>
#include <vector>
#include "Variable.h"
#include "VariableTable.h"

using namespace std;

class Function
{
private:
    string funName;
    string funType;
    string funAddress;
    vector<Variable*> paramList;
    VariableTable localVars;
public:
    Function(string name, string type, string address);
    Function(string name, string type, string address, vector<Variable*> prmLst, VariableTable* lclVars);

    string getFunName();
    string getFunType();
    string getFunAddress();
    vector<Variable*> getParamList();
    VariableTable getLocalVars();

    void addParam(Variable* v);
    void addLocalVaraible(Variable* v);

    void setFunName(string s);
    void setFunType(string s);
    void setFunAddress(string s);
};


#endif //ASSIGNMENT_3_PARSER_FUNCTION_H
