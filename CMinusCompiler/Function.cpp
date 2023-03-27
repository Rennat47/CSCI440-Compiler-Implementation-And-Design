/*
 * Author(s): Tanner Smith, Jonathan Stephens
 * Last Updated: 11/11/2021
 * Description: A Class to represent a function, and it's components from the cminus language
 */

#include "Function.h"
Function::Function(string name, string type, string address)
{
    funName = name;
    funType = type;
    funAddress = address;
}

Function::Function(string name, string type, string address, vector<Variable *> prmLst, VariableTable* lclVars) //unused but possibly useful in the future
{
    funName = name;
    funType = type;
    funAddress = address;
    paramList = prmLst;
    localVars = *lclVars;
}
/*
 * Getters
 */
string Function::getFunName()
{
    return funName;
}

string Function::getFunType()
{
    return funType;
}

string Function::getFunAddress()
{
    return funAddress;
}

vector<Variable *> Function::getParamList()
{
    return paramList;
}

VariableTable Function::getLocalVars()
{
    return localVars;
}
/*
 * add functions
 */
void Function::addParam(Variable * v)
{
    paramList.push_back(v);
}

void Function::addLocalVaraible(Variable *v)
{
    localVars.addVariable(v);
}

void Function::setFunName(string s)
{
    funName = s;
}

void Function::setFunType(string s)
{
    funType = s;
}

void Function::setFunAddress(string s)
{
    funAddress = s;
}



