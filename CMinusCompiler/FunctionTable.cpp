/*
 * Author(s): Tanner Smith, Jonathan Stephens
 * Last Updated: 11/11/2021
 * Description: A table that holds the functions of a cminus program
 */
#include "FunctionTable.h"

FunctionTable::FunctionTable()
{

}

FunctionTable::FunctionTable(treenode *node) //Constructor should take the root
{
    generateFunctionTable(node, "global"); //What actually sets values in the table
}

void FunctionTable::addFunction(Function* func)
{
    functions.insert((make_pair(func->getFunName(), func)));
}

void FunctionTable::printTable()
{
    for(map<string, Function*>::iterator i = functions.begin(); i != functions.end(); i++) //Goes through all the functions in the function table
    {
        Function func = *i->second;
        cout << "Function \t" << func.getFunName() << "\t" << func.getFunType() << "\t" << func.getFunAddress() << endl; //Prints out the functions name type and address
        cout << setw(20) << "Parameters";
        if (func.getParamList().size() == 0) //Checks to see if there are no parameters
            cout << "\t -- ParameterList is empty" << endl;
        else
            cout << endl << setw(20) << "Name"  << setw(20) << "Type"  << setw(20) << "Size"  << setw(20) << "Scope"  << setw(20) << "Address" << endl;

        for (int i = 0; i < func.getParamList().size(); i++) //Goes through the parameters of the function
        {
            Variable v = *func.getParamList().at(i); //Gets the variable from the map entry of the current iteration.
            int number = v.getVarSize(); //temp int
            char result[16]; //temp char
            sprintf (result, "%d", number); //converts int to string
            cout << setw(20) << v.getVarName()  << setw(20) << v.getVarType() << setw(20) << result << setw(20) << v.getVarScope() << setw(20) << v.getVarAddress() << endl;
        }
        cout << setw(20) << "Local Variables" << endl;
        func.getLocalVars().printTable(); //Calls the print table print method for the variable table
    }
}

void FunctionTable::generateFunctionTable(treenode *n, string scope)
{
    int ruleNum = n->getRuleNum();
    string newScope = scope; //New scope only gets updated if we are on a function declaration
    if (ruleNum == 60) //func declaration rule
    {
        newScope = n->getText();
        this->addFunction(new Function(n->getText(), n->getType(), "0")); //adds a function to the function table
    }
    if (scope != "global") //We only care about these declarations if were not in the global scope. Since were building the function table
    {
        //Maybe replace this with a switch statement?
        if(ruleNum == 90) //Param declaration rule
            this->functions.at(scope)->addParam(new Variable(n->getText(), n->getType(), 1, scope, "0")); //asks the table for the function of this scope and adds a param to it
        if(ruleNum == 91)//Param[] declaration rule
            this->functions.at(scope)->addParam(new Variable(n->getText(), n->getType(), n->getIntValue(), scope, "0")); //asks the table for the function of this scope and adds a param[] to it
        if (ruleNum == 40) //Var declaration rule
            this->functions.at(scope)->addLocalVaraible(new Variable(n->getText(), n->getType(), 1, scope, "0")); //asks the table for the function of this scope and adds a var to it
        if (ruleNum == 41)//Var[] declaration rule
            this->functions.at(scope)->addLocalVaraible(new Variable(n->getText(), n->getType(), n->getIntValue(), scope, "0"));//asks the table for the function of this scope and adds a var[] to it

    }
    for (int i = 0; i < n->getChildren().size(); ++i) //Loop through and recursively call on the node's children
    {
        treenode* child = n->getChildren().at(i);
        generateFunctionTable(child, newScope); //Passes the new scope to the children since in theory if the scope changes the children of the node should share the same scope.
    }
}

Function* FunctionTable::getFunction(string funcName)
{
   return functions.at(funcName);
}


