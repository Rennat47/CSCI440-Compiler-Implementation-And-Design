/*
 * Author(s): Tanner Smith, Jonathan Stephens
 * Last Updated: 11/11/2021
 * Description: Class to represent a variable of the cminus language
 */

#include "Variable.h"

Variable::Variable(string name, string type, int size, string scope, string address)
{
    varName = name;
    varType = type;
    varSize = size;
    varScope = scope;
    varAddress = address;
}
/*
 * getters
 */
string Variable::getVarName()
{
    return varName;
}

string Variable::getVarType()
{
    return varType;
}

int Variable::getVarSize()
{
    return varSize;
}

string Variable::getVarScope()
{
    return varScope;
}

string Variable::getVarAddress()
{
    return varAddress;
}

void Variable::setVarName(string s)
{
    varName = s;
}

void Variable::setVarType(string s)
{
    varType = s;
}

void Variable::setVarSize(int n)
{
    varSize = n;
}

void Variable::setVarScope(string s)
{
    varScope = s;
}

void Variable::setVarAddress(string s)
{
    varAddress = s;
}


