/*
 * Author(s): Tanner Smith, Jonathan Stephens
 * Last Updated: 11/11/2021
 * Description: A Class to represent an n-ary tree, with intent to be used for a parse tree
 */


#ifndef ASSIGNMENT_ONE_TREENODE_H
#define ASSIGNMENT_ONE_TREENODE_H
#include <vector>
#include "string"

using namespace std;

class treenode
{
private:
    int ruleNum;
    string text;
    string type;
    int intValue;
    //int depth;
    vector<treenode *> children;
public:

    treenode(int rule, string txt);

    treenode(int rule, string txt, string typ);

    treenode(int rule, string txt, int intVal);

    treenode(int rule, string txt, string typ, int intVal);

    int getRuleNum();
    string getText();
    string getType();
    int getIntValue();
    vector<treenode*> getChildren();

    void addChild(treenode* node);

    void preorder_print();
};


#endif //ASSIGNMENT_ONE_TREENODE_H
