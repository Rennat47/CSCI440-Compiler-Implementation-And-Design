/*
 * Author(s): Tanner Smith, Jonathan Stephens
 * Last Updated: 11/11/2021
 * Description: Class to represent a variable of the cminus language
 */

#ifndef ASSIGNMENT_3_PARSER_VARIABLE_H
#define ASSIGNMENT_3_PARSER_VARIABLE_H
#include <string>
#include <iostream>
#include <cstdio>
#include <iomanip>
using namespace std;

class Variable
{
private:
     string varName;
     string varType;
     int varSize;
     string varScope;
     string varAddress;
public:
    Variable(string name, string type, int size, string scope, string address);

    string getVarName();
    string getVarType();
    int getVarSize();
    string getVarScope();
    string getVarAddress();

    void setVarName(string s);
    void setVarType(string s);
    void setVarSize(int n);
    void setVarScope(string s);
    void setVarAddress(string s);

};


#endif //ASSIGNMENT_3_PARSER_VARIABLE_H
