//
// Created by Tanner Smith on 12/2/2021.
//

#include "backfillLine.h"

backfillLine::backfillLine(int n, string s)
{
    lineNumber = n;
    funcName = s;
}

int backfillLine::getLineNumber()
{
    return lineNumber;
}

string backfillLine::getFuncName()
{
    return funcName;
}
