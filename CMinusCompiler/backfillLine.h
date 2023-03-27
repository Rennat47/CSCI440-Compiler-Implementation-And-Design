//
// Created by Tanner Smith on 12/2/2021.
//

#ifndef ASSIGNMENT_3_PARSER_BACKFILLLINE_H
#define ASSIGNMENT_3_PARSER_BACKFILLLINE_H

#include <string>

using namespace std;
class backfillLine
{

private:
    int lineNumber;
    string funcName;

public:

    backfillLine(int n, string s);

    int getLineNumber();
    string getFuncName();
};


#endif //ASSIGNMENT_3_PARSER_BACKFILLLINE_H
