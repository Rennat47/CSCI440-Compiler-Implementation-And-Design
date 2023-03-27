/*
 * Author(s): Tanner Smith, Jonathan Stephens
 * Last Updated: 11/11/2021
 * Description: A table that holds variable's of the cminus language
 */
#include "VariableTable.h"

VariableTable::VariableTable()
{

}

VariableTable::VariableTable(treenode *node)//Constructor should be used on the root
{
        populateGlobal(node); //What actually sets values in the table
}


void VariableTable::addVariable(Variable *var)
{
    variables.insert((make_pair(var->getVarName(), var)));
}

void VariableTable::printTable()
{
    cout << setw(20) << "Name"  << setw(20) << "Type"  << setw(20) << "Size"  << setw(20) << "Scope"  << setw(20) << "Address" << endl;
    for(map<string, Variable*>::iterator i = variables.begin(); i != variables.end(); i++)
    {
        Variable v = *i->second; //Gets the variable from the map entry of the current iteration.
        int number = v.getVarSize(); //temp int
        char result[16]; //temp char
        sprintf (result, "%d", number); //converts int to string
        cout << setw(20) << v.getVarName()  << setw(20) << v.getVarType() << setw(20) << result << setw(20) << v.getVarScope() << setw(20) << v.getVarAddress() << endl;
    }
    cout << endl;
}

void VariableTable::populateGlobal(treenode *n) //Does not need scope since scope should always be global by skipping over functions.
{
    int ruleNum = n->getRuleNum();
    if (ruleNum == 60) //Function Declaration rule
        return; //Returns before going deeper into function. We ONLY care about global variables here.
    if (ruleNum == 40)//Var Declaration rule
        this->addVariable(new Variable(n->getText(), n->getType(), 1, "global", "0"));
    if (ruleNum == 41)//Var[] Declaration rule
        this->addVariable(new Variable(n->getText(), n->getType(), n->getIntValue(), "global", "0"));

    for (int i = 0; i < n->getChildren().size(); ++i) //Iterates through children and makes recursive calls
    {
        treenode *child = n->getChildren().at(i);
        populateGlobal(child);
    }
}

Variable *VariableTable::getVariable(string s)
{
    return variables.at(s);
}

map<string, Variable *>* VariableTable::getVariables()
{
    return &variables;
}

int VariableTable::getTotalSize()
{
    int totalSize = 0;
    for(map<string, Variable*>::iterator i = variables.begin(); i != variables.end(); i++)
    {
        Variable v = *i->second; //Gets the variable from the map entry of the current iteration.
        totalSize += v.getVarSize();
    }
    return totalSize;
}





