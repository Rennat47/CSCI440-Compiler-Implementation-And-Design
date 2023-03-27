/*
 * Author(s): Tanner Smith, Jonathan Stephens
 * Last Updated: 11/11/2021
 * Description: A Class to represent an n-ary tree, with intent to be used for a parse tree
 */

#include <iostream>
#include "treenode.h"

using namespace std;
int depth = 0; //global var used for printing

treenode::treenode(int rule, string txt)
{
    ruleNum = rule;
    text = txt;
    type = "";
}

treenode::treenode(int rule, string txt, string typ)
{
    ruleNum = rule;
    text = txt;
    type = typ;
}

treenode::treenode(int rule, string txt, int intVal)
{
    ruleNum = rule;
    text = txt;
    type = "";
    intValue = intVal;
}

treenode::treenode(int rule, string txt, string typ, int intVal)
{
    ruleNum = rule;
    text = txt;
    type = typ;
    intValue = intVal;
}

int treenode::getRuleNum()
{
    return ruleNum;
}
string treenode::getText()
{
    return text;
}
string treenode::getType()
{
    return type;
}
int treenode::getIntValue()
{
    return intValue;
}

vector<treenode *> treenode::getChildren()
{
    return children;
}

void treenode::addChild(treenode *node)
{
    children.push_back(node);
}

void treenode::preorder_print()
{
    for(int i = 1; i < depth; ++i)
        cout << "   "; //adds whitespace
    cout << ruleNum << " " << text << " "; //prints the rule num and text
    if (type != "")
        cout << type < " "; //Only prints the type if there is a type
    cout << endl;
    for (vector<treenode*>::iterator i = children.begin(); i < children.end(); ++i) //iterate through this node's children and recursively call the print
    {
        cout << "   ";
        treenode* n = *i; //sets treenode to the current iteration
        depth++; //increase depth then call print on current child node
        n->preorder_print();
        depth--;
       // n->depth--;
    }

}



