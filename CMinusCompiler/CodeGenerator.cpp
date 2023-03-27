//
// Author(s): Tanner Smith, Jonathan Stephens
// Last Updated: 12/7/2021
//

#include "CodeGenerator.h"

ofstream outFile;

CodeGenerator::CodeGenerator(treenode *n)
        : PC_REG(7), GP_REG(6), FP_REG(5), SP_REG(4)
{
    root = n;
    globalTable = VariableTable(n);
    functionTable = FunctionTable(n);
}

void CodeGenerator::generateCode(string fileName)
{
    fileName = fileName.substr(0,fileName.length()-2) + "tm"; //Trim .cm and add .tm to the file name
    outFile.open(fileName.c_str(), ios::out); //.c_str() since that is what the .open method wants
    currentLine = 0;
    currentScope = "global";
    updateGlobals();
    functionCall("main"); //Force a call to main
    addROInstruction(currentLine, "HALT", 0, 0, 0, "END OF PROGRAM (after main)");
    processDeclarations(root); //Call to build the program
    backfill(); //Backfill function calls
    outFile.close();
    //Uncomment to print tables
    globalTable.printTable();
    functionTable.printTable();
}

void CodeGenerator::processDeclarations(treenode *n)
{

    if(n->getRuleNum() == 60) //Function Declaration
    {
        //Set the address of the function in the function table to the currentLine (aka next available line)
        //The next instruction generated should be the start of the function in instruction memory.
        Function * func = functionTable.getFunction(n->getText());
        func->setFunAddress(intToString(currentLine));
        vector<Variable *>  params = func->getParamList();
        map<string, Variable*> localVars = *functionTable.getFunction(n->getText())->getLocalVars().getVariables();
        /*
             *                                  0x29 <----- SP
             *      temps                       0x30
             *      locals                      0x31
             *      return addr                 0x32 <------FP
             *      Old FP                      0x33
             *      params                      0x34
             *                                  0x35
             * Params will get pushed onto the stack in order first to last
             * that means the first param will be at the highest memory address
             *
             */
        //Update the memory addresses of the parameters relative to the FP
        for (int i = 0; i < params.size(); ++i)
        {
            params.at(i)->setVarAddress(intToString(1 + params.size() - i));

        }
        int relAddress = 0;
        //Update the function table local variable addresses
        for(map<string, Variable*>::iterator i = localVars.begin(); i != localVars.end(); i++)
        {
            Variable* v = & *i->second;
            relAddress -= v->getVarSize();
            v->setVarAddress(intToString(relAddress));
        }
        currentScope = n->getText(); //set the scope to the function name
        //build the body of the function
        addComment("Start of function " + n->getText());
        processDeclarations(n->getChildren().at(1));
        returnNoValue(); //Always return after a function call. This may be redundant if the function returns by itself.
        currentScope = "global"; //reset the scope done building the body
        return; //Return since we already went into all the children
    } else if (n->getRuleNum() == 140) //Handle expression statement
    {
        expressionStatement(n->getChildren().at(0));
        return; //Return, don't go into the children. Was already handled.
    } else if (n->getRuleNum() == 150 || n->getRuleNum() == 151) //if statement. OR If else statement
    {
        selectionStatement(n);
        return; //Return, don't go into the children. Was already handled.
    } else if (n->getRuleNum() == 160)
    {
        iterationStatement(n);
        return; //Return, don't go into the children. Was already handled.
    } else if (n->getRuleNum() == 170) //return;
    {
        returnNoValue();
        return; //Return, don't go into the children. Was already handled.
    } else if (n->getRuleNum() == 171) //return <expression>;
    {
        returnWithValue(n);
        return;
    }

    for (int i = 0; i < n->getChildren().size(); ++i) //Iterates through children and makes recursive calls
    {
        treenode *child = n->getChildren().at(i);
        processDeclarations(child);
    }
}

void CodeGenerator::addROInstruction(int lineNum, string opcode, int r, int s, int t)
{
    addROInstruction(lineNum, opcode, r, s, t, "");
}

void CodeGenerator::addROInstruction(int lineNum, string opcode, int r, int s, int t, string comment)
{
    outFile << lineNum << ":   " << opcode << "   " << r << ", " << s << ", " << t << "\t" << comment << endl;
    currentLine++;
}

void CodeGenerator::addRMInstruction(int lineNum, string opcode, int r, int d, int s)
{
    addRMInstruction(lineNum, opcode, r, d, s, "");
}

void CodeGenerator::addRMInstruction(int lineNum, string opcode, int r, int d, int s, string comment)
{
    outFile << lineNum << ":   " << opcode << "   " << r << ", " << d << "(" << s << ")" << "\t "<<comment << endl;
    currentLine++;
}

void CodeGenerator::addComment(string comment)
{
    outFile << "* " << comment << endl;
}

void CodeGenerator::backfill()
{
    for(int i = 0; i < backfillLines.size(); i++)
    {
        backfillLine l = backfillLines.at(i);
        int funcAddress = stringToInt(functionTable.getFunction(l.getFuncName())->getFunAddress());
        addRMInstruction(l.getLineNumber(), "LDC", PC_REG, funcAddress, 0, "Backfill function call to " + l.getFuncName());
    }
}

string CodeGenerator::intToString(int n)
{
    char result[16]; //temp char
    sprintf (result, "%d", n); //converts int to string
    return result;
}

int CodeGenerator::stringToInt(string s)
{
    int result;
    sscanf(s.c_str(), "%d", &result);
    return result;
}

void CodeGenerator::updateGlobals()
{
    addRMInstruction(currentLine, "LD", GP_REG, 0, 0, "Set the GP to the max data memory");
    addRMInstruction(currentLine, "ST", 0, 0, 0, "clear data memory address 0");
    map<string, Variable*>* variables = globalTable.getVariables();
    int relAddress = 1;
    for(map<string, Variable*>::iterator i = variables->begin(); i != variables->end(); i++)
    {
        Variable* v = & *i->second; //Gets the variable from the map entry of the current iteration.
        relAddress -= v->getVarSize();
        v->setVarAddress(intToString(relAddress));
        //cout << intToString(relAddress) << "   " << v->getVarAddress() << endl; //debug line
        //relAddress--; //old code
    }
    //Update the stack pointer register to 1 above the last global variable. SP = relativeAddress + GP
    addRMInstruction(currentLine, "LDA", SP_REG, relAddress - 1, GP_REG, "Update the SP to the next free spot after the globals");
    addRMInstruction(currentLine, "LDA", FP_REG, 0, SP_REG, "Set the FP to the SP");
}

void CodeGenerator::input(int r) //r = what register to put the input to
{
    addROInstruction(currentLine, "IN", r, 0, 0, " getting user input");
}

void CodeGenerator::output(int r) //r = what register to output from
{
    addROInstruction(currentLine, "OUT", r, 0, 0, "outputting value");
}

void CodeGenerator::loadGlobal(treenode * n, int r)
{
    string varName = n->getChildren().at(0)->getText();
    int offset = stringToInt(globalTable.getVariable(varName)->getVarAddress());
    //cout << endl << "load global call on " << varName << " rule num: " << n->getRuleNum();
    if (n->getRuleNum() == 190)//int x;
    {
        if (globalTable.getVariable(varName)->getVarSize() > 1)
        {
            addRMInstruction(currentLine, "LDA", r, offset, GP_REG, "load global var [] as param: " + varName);

        } else
        {
            addRMInstruction(currentLine, "LD", r, offset, GP_REG, "load global var: " + varName);
        }
    } else if (n->getRuleNum() == 191)//int x[expression];
    {
        //Note that load global is called after the expression has already been pushed onto the stack
        pop(1); //loads the calculated expression value into reg 1
        addRMInstruction(currentLine, "LDC", 2, offset, 0); //loads the base address of the variable relative to the gp into reg 2
        addROInstruction(currentLine, "ADD", 0, 1, 2, "calculate relative to GP array address"); //calculate the address of the array at index <expression> relative to GP
        addROInstruction(currentLine, "ADD", 0, 0, GP_REG, "calculate absolute array address"); //calculates the absolute address of array at index <expression>
        addRMInstruction(currentLine, "LD", r, 0, 0, "load global var[]: " + varName);
    }

}

void CodeGenerator::storeGlobal(treenode * n, int r)
{
    string varName = n->getChildren().at(0)->getText();
    int offset = stringToInt(globalTable.getVariable(varName)->getVarAddress());
    if (n->getRuleNum() == 190)//int x;
    {
        //pop(r);
        addRMInstruction(currentLine, "ST", r, offset, GP_REG, "store global variable: " + varName);
    } else if (n->getRuleNum() == 191)//int x[<expression>]
    {
        //Note that load global is called after the expression has already been pushed onto the stack
        pop(1); //loads the calculated expression value into reg 1
        addRMInstruction(currentLine, "LDC", 2, offset, 0); //loads the base address of the variable relative to the gp into reg 2
        addROInstruction(currentLine, "ADD", 0, 1, 2, "calculate relative to GP array address"); //calculate the address of the array at index <expression> relative to GP
        addROInstruction(currentLine, "ADD", 0, 0, GP_REG, "calculate absolute array address"); //calculates the absolute address of array at index <expression>
        pop(1);//Pop the value to be stored into reg 1
        addRMInstruction(currentLine, "ST", 1, 0, 0, "store global variable [] " + varName);
    }
}

void CodeGenerator::push(int r)
{
    addComment("Stack Push");
    addRMInstruction(currentLine, "ST", r, 0, SP_REG);
    addRMInstruction(currentLine, "LDA", SP_REG, -1, SP_REG);

}

void CodeGenerator::pop(int r)
{
    addComment("Stack Pop");
    addRMInstruction(currentLine, "LD", r, 1, SP_REG);
    addRMInstruction(currentLine, "LDA", SP_REG, 1, SP_REG);
}

void CodeGenerator::additiveExpression(treenode * n) //Takes any node and will calculate all additive expressions. Then push them onto the stack
{

    for (int i = 0; i < n->getChildren().size(); ++i) //Iterates through children and makes recursive calls
    {
        treenode *child = n->getChildren().at(i);
        additiveExpression(child);
    }
    if(n->getRuleNum() == 261) //Factor -> variable
    {
        //string varname = n->getChildren().at(0)->getChildren().at(0)->getText(); //old code
        //cout << endl << varname << " var has an int value of: " <<  n->getChildren().at(0)->getChildren().at(0)->getIntValue(); //old code
        loadVariable(n->getChildren().at(0), 0);
        push(0);
    }else if (n->getRuleNum() == 262) //Factor -> Call
    {
        //Fix later currently assuming all function calls are input
        string funcName = n->getChildren().at(0)->getText();
        if (funcName == "input")
        {
            input(0);
            push(0);
        } else if (funcName == "output")
        {
            pop(0);
            output(0);
        } else
        {
            addComment("Function Call");
            functionCall(n->getChildren().at(0)->getText());
        }
    }
    else if(n->getRuleNum() == 263) //Factor -> some constant
    {
        int constvalue = n->getChildren().at(0)->getIntValue();
        addRMInstruction(currentLine, "LDC", 0, constvalue, 0, "Load constant: " + intToString(constvalue));
        push(0);
    } else if (n->getRuleNum() == 240) //Mulop - assumes the stack contains the left and right side of the expression
    {
        string mulop = n->getChildren().at(1)->getText();
        pop(2); //get arg 2 into reg 2 (right side)
        pop(1); //get arg 1 into reg 1 (left side)
        if (mulop == "*")
        {
            addROInstruction(currentLine, "MUL", 0, 1, 2);
        }
        else if (mulop == "/")
        {
            addROInstruction(currentLine, "DIV", 0, 1, 2);
        }
        push(0); //push result to stack
    } else if (n->getRuleNum() == 220)
    {
        string addop = n->getChildren().at(1)->getText();
        pop(2); //get arg 2 into reg 2 (right side)
        pop(1); //get arg 1 into reg 1 (left side)
        if (addop == "+")
        {
            addROInstruction(currentLine, "ADD", 0, 1, 2);
        }
        else if (addop == "-")
        {
            addROInstruction(currentLine, "SUB", 0, 1, 2);
        }
        push(0);//push result to stack
    }
}

void CodeGenerator::comparisonExpression(treenode *n) //Takes node 180 or 181
{
    // num1 relop num2
    string relop = n->getChildren().at(0)->getChildren().at(1)->getText();
    additiveExpression(n);
    //num2 is on top of the stack
    pop(2);
    pop(1);
    //num1 - num2
    addROInstruction(currentLine, "SUB", 0, 1, 2);
    if (relop == ">")
    {
        addRMInstruction(currentLine, "JGT", 0, 2, PC_REG);
    } else if (relop == ">=")
    {
        addRMInstruction(currentLine, "JGE", 0, 2, PC_REG);
    } else if (relop == "<")
    {
        addRMInstruction(currentLine, "JLT", 0, 2, PC_REG);
    } else if (relop == "<=")
    {
        addRMInstruction(currentLine, "JLT", 0, 2, PC_REG);
    } else if (relop == "==")
    {
        addRMInstruction(currentLine, "JEQ", 0, 2, PC_REG);
    } else if (relop == "!=")
    {
        addRMInstruction(currentLine, "JNE", 0, 2, PC_REG);
    }
    //If the comparison is true it will jump past the ldc
    addRMInstruction(currentLine, "LDC", 0, 0, 0); //False load 0 into reg 0 and skip past the load 1
    addRMInstruction(currentLine, "LDA", PC_REG, 1, PC_REG);
    addRMInstruction(currentLine, "LDC", 0, 1, 0); //True load 1 into reg 0
    push(0); //push the result onto the stack (is either 0 or 1)

}

void CodeGenerator::expressionStatement(treenode *n)
{
    if (n->getRuleNum() == 180) //var = expression
    {
        treenode * expressionNode = n->getChildren().at(1)->getChildren().at(0);
        string varName = n->getChildren().at(0)->getChildren().at(0)->getText();
        if (expressionNode->getRuleNum() == 200)
        {
            comparisonExpression(n);
        }
        else if (expressionNode->getRuleNum() == 201)
        {
            additiveExpression(n);
        }
        storeVariable(n->getChildren().at(0), 0);
    } else if (n->getRuleNum() == 181) //expression
    {
        treenode * expressionNode = n->getChildren().at(0);
        if (expressionNode->getRuleNum() == 200)
        {
            comparisonExpression(n);
        }
        else if (expressionNode->getRuleNum() == 201)
        {
            additiveExpression(n);
        }
    }
}

void CodeGenerator::selectionStatement(treenode *n)
{
    int backfillLine;

        expressionStatement(n->getChildren().at(0)); //Pushes a 1 or 0 to the top of the stack
        pop(0);
        addComment("Line here will be backfilled");
        backfillLine = currentLine; //Prepare to backfill the jump;
        currentLine++;
        addComment("Start of if body");
    processDeclarations(n->getChildren().at(1)); //build the body of the if
        //Calculate the backfill jump amount and add the backfill line
        addComment("Backfill line");
        int jumpAmount = currentLine - backfillLine;
        if (n->getRuleNum() == 150)
        {
            //jumpAmount - 1 could be due to a bug in my tiny machine sim because I think it should be just jump amount
            //needs to be tested on the regular tiny machine
            addRMInstruction(backfillLine, "JEQ", 0, jumpAmount - 1, PC_REG, "If statement jump"); //jump if 0 == 0 (i.e jump if false)
            currentLine--; //addRMInstruction increases the line but this line is being backfilled so we must decrease the count
            addComment("End of if statement body");
        } else if(n->getRuleNum() == 151)
        {
            addRMInstruction(backfillLine, "JEQ", 0, jumpAmount, PC_REG, "If-Else statement jump"); //jump if 0 == 0 (i.e jump if false)
            backfillLine = currentLine - 1;
            addComment("End of if statement body");
            addComment("Start of else statement body");
            processDeclarations(n->getChildren().at(2));//build the body of the else
            addRMInstruction(backfillLine, "LDC", PC_REG, currentLine, 0, "Jump past else part");
            currentLine--;
            addComment("End of else statement body");
        }
}

void CodeGenerator::compoundStatement(treenode *n)
{

}

void CodeGenerator::iterationStatement(treenode *n)
{
    int backfillLine;
    int topOfWhile = currentLine;
    expressionStatement(n->getChildren().at(0)); //Pushes a 1 or 0 to the top of the stack
    pop(0);
    addComment("Line here will be backfilled");
    backfillLine = currentLine; //Prepare to backfill the jump;
    currentLine++;
    addComment("Start of while body");
    processDeclarations(n->getChildren().at(1)); //build the body of the if
    //Calculate the backfill jump amount and add the backfill line
    addRMInstruction(currentLine, "LDC", PC_REG, topOfWhile, 0, "Jump back to top of while");
    addComment("Backfill line");
    int jumpAmount = currentLine - backfillLine;
    addRMInstruction(backfillLine, "JEQ", 0, jumpAmount - 1, PC_REG, "Jump out of while"); //jump if 0 == 0 (i.e jump if false)
    currentLine--; //addRMInstruction increases the line but this line is being backfilled so we must decrease the count
    addComment("End of while body");
}

void CodeGenerator::returnWithValue(treenode *n)
{
    //Calculate the return value and put it into register 3
    addComment("Start of code to return with value");
    expressionStatement(n->getChildren().at(0));
    addComment("Store return value into reg 3");
    pop(3);
    //Return the stack pointer to before this frame was called
    addRMInstruction(currentLine, "LDA", SP_REG, 1 + functionTable.getFunction(currentScope)->getParamList().size(), FP_REG, "Reset stack pointer to before the frame");
    //Load the return address into reg 0
    addRMInstruction(currentLine, "LD", 0, 0, FP_REG, "Load return address into reg 0");
    //Load the old frame pointer value into the frame pointer
    addRMInstruction(currentLine, "LD", FP_REG, 1, FP_REG, "Load old FP into FP");
    //Push register 3 (holds the return value) onto the stack.
    push(3);
    //Jump to the return address (Register 0 holds the return address)
    addRMInstruction(currentLine, "LDA", PC_REG, 0, 0, "Jump back to return address");
    addComment("End of code to return with value");

}

void CodeGenerator::returnNoValue()
{
    addComment("Start of code return no value");
    //Return the stack pointer to before this frame was called
    addRMInstruction(currentLine, "LDA", SP_REG, 1 + functionTable.getFunction(currentScope)->getParamList().size(), FP_REG, "Reset stack pointer to before the frame");
    //Load the return address into reg 0
    addRMInstruction(currentLine, "LD", 0, 0, FP_REG, "Load return address into reg 0");
    //Load the old frame pointer value into the frame pointer
    addRMInstruction(currentLine, "LD", FP_REG, 1, FP_REG, "Load old FP into FP");
    //Push register 3 (holds the return value) onto the stack.
    //Jump to the return address (Register 0 holds the return address)
    addRMInstruction(currentLine, "LDA", PC_REG, 0, 0, "Jump back to return address");
    addComment("End of code return no value");
}

void CodeGenerator::functionCall(string s)
{
    string funcName = s;
    //Push the old frame pointer onto the stack
    push(5);
    //Load the return address into r0 then push that onto the stack
    addRMInstruction(currentLine, "LDC", 0, currentLine + 6, 0, "Load pre-calculated return address into reg 0 to be pushed onto stack");
    push(0);
    //Update the frame pointer
    addRMInstruction(currentLine, "LDA", FP_REG, 1, SP_REG, "Update Frame Pointer");
    //cout << endl << s << "-----" << functionTable.getFunction(s)->getLocalVars().getVariables()->size();
    int numOfLocalVars = functionTable.getFunction(s)->getLocalVars().getTotalSize();
    addRMInstruction(currentLine, "LDA", SP_REG, -numOfLocalVars, 4, "Increase the Stack Pointer to after the local vars");
    backfillLine l = backfillLine(currentLine, funcName);
    backfillLines.push_back(l);
    currentLine++;
}

void CodeGenerator::loadVariable(treenode * n, int r)
{
    Function *f = functionTable.getFunction(currentScope);
    VariableTable localVariables = f->getLocalVars();
    string varName = n->getChildren().at(0)->getText();
    int relativeAddress;
    if (n->getRuleNum() == 190) //int x
    {
        if (localVariables.getVariables()->count(varName) > 0)
        {
            relativeAddress = stringToInt(localVariables.getVariable(varName)->getVarAddress());
            if (localVariables.getVariable(varName)->getVarSize() > 1) //This local var is being used as a param calculate it's address instead;
            {
                addRMInstruction(currentLine, "LDA", r, relativeAddress, FP_REG, "Loading local var[] for param");
            } else
            {
                addRMInstruction(currentLine, "LD", r, relativeAddress, FP_REG, "Loading local Var");
            }
        } else
        {
            for (int i = 0; i < f->getParamList().size(); i++)
            {
                if (varName == f->getParamList().at(i)->getVarName())
                {
                    //Load param
                    relativeAddress = stringToInt(f->getParamList().at(i)->getVarAddress());
                    addRMInstruction(currentLine, "LD", r, relativeAddress, FP_REG, "Loading param");
                    return;
                }
            }
            //No Param was found
            loadGlobal(n, r);
        }
    } else if (n->getRuleNum() == 191)//int x[expression]
    {

        //Calculate the array offset and push it onto the stack
        //additiveExpression(n->getChildren().at(1));
        if (localVariables.getVariables()->count(varName) > 0)
        {
            relativeAddress = stringToInt(localVariables.getVariable(varName)->getVarAddress());
            pop(1); //loads the calculated expression value into reg 1
            addRMInstruction(currentLine, "LDC", 2, relativeAddress, 0); //loads the base address of the variable relative to the FP into reg 2
            addROInstruction(currentLine, "ADD", 0, 1, 2, "calculate relative to FP array address"); //calculate the address of the array at index <expression> relative to FP
            addROInstruction(currentLine, "ADD", 0, 0, FP_REG, "calculate absolute array address"); //calculates the absolute address of array at index <expression>
            addRMInstruction(currentLine, "LD", r, 0, 0, "load local var[]: " + varName);
        } else
        {
            for (int i = 0; i < f->getParamList().size(); i++)
            {
                if (varName == f->getParamList().at(i)->getVarName())
                {
                    //Load param
                    relativeAddress = stringToInt(f->getParamList().at(i)->getVarAddress());
                    addRMInstruction(currentLine, "LD", 0, relativeAddress, FP_REG, "Loading param[]'s reference");
                    pop(1); //Pop the calculated expression into r1
                    addROInstruction(currentLine, "ADD", 0, 0, 1);
                    addRMInstruction(currentLine, "LD", r, 0, 0); //Loads the param offset by the reference
                    return;
                }
            }
            //No Param was found
            loadGlobal(n, r);
        }
    }

}

void CodeGenerator::storeVariable(treenode * n, int r)
{
    Function *f = functionTable.getFunction(currentScope);
    VariableTable localVariables = f->getLocalVars();
    int relativeAddress;
    string varName = n->getChildren().at(0)->getText();
    if (n->getRuleNum() == 190)
    {
        pop(r); //Loads value to be stored into reg 0
        if (localVariables.getVariables()->count(varName) > 0)
        {
            relativeAddress = stringToInt(localVariables.getVariable(varName)->getVarAddress());
            addRMInstruction(currentLine, "ST", r, relativeAddress, FP_REG, "Storing Local Var");
        } else
        {
            for (int i = 0; i < f->getParamList().size(); i++)
            {
                if (varName == f->getParamList().at(i)->getVarName())
                {
                    //Load param
                    relativeAddress = stringToInt(f->getParamList().at(i)->getVarAddress());
                    addRMInstruction(currentLine, "ST", r, relativeAddress, FP_REG, "Storing param");
                    return;
                }
            }
            //No Param was found
            storeGlobal(n, r);
        }
    } else if (n->getRuleNum() == 191)
    {
        //Calculate the array offset and push it onto the stack
        additiveExpression(n->getChildren().at(1));
        if (localVariables.getVariables()->count(varName) > 0)
        {
            relativeAddress = stringToInt(localVariables.getVariable(varName)->getVarAddress());
            pop(1); //loads the calculated expression value into reg 1
            addRMInstruction(currentLine, "LDC", 2, relativeAddress, 0); //loads the base address of the variable relative to the fp into reg 2
            addROInstruction(currentLine, "ADD", 0, 1, 2, "calculate relative to FP array address"); //calculate the address of the array at index <expression> relative to fP
            addROInstruction(currentLine, "ADD", 0, 0, FP_REG, "calculate absolute array address"); //calculates the absolute address of array at index <expression>
            pop(1);//Pop the value to be stored into reg 1
            addRMInstruction(currentLine, "ST", 1, 0, 0, "store local variable [] " + varName);
        } else
        {
            for (int i = 0; i < f->getParamList().size(); i++)
            {
                if (varName == f->getParamList().at(i)->getVarName())
                {
                    //Load param
                    relativeAddress = stringToInt(f->getParamList().at(i)->getVarAddress());
                    addRMInstruction(currentLine, "LD", 0, relativeAddress, FP_REG, "Loading param[]'s reference");
                    pop(1); //Pop the calculated expression into r1
                    addROInstruction(currentLine, "ADD", 0, 0, 1);
                    pop(1); //Pop the value to be stored into reg 1;
                    addRMInstruction(currentLine, "ST", 1, 0, 0, "store local variable [] " + varName);
                    return;
                }
            }
            //No Param was found
            storeGlobal(n, r);
        }
    }
}






