/*
    Tanner Smith, 9/30/2021
    Project 2 Scanner for CSCI 440
    This file is to be compiled through FLEX and will generate a Scanner.cpp
    file that will compile to scan .cm files (CMinus) code and covert it
    into tokens.
*/


/****************************************************/
/* File: CMinus.l                                   */
/* Lex specification for C- language from           */
/* Compiler Construction: Principles and Practice   */
/*                                                  */
/* To compile and run:                              */
/*   flex CMinus.l                                  */
/*   g++ lex.yy.c                                   */
/*   ./a.out < cminusfilename                       */
/* Note the redirection arrow, < , is needed.       */
/****************************************************/

%{
#include <iostream>
#include <iomanip>

/* Parser.hhp has all the token definitions */
#include "common.h"
#include "Parser.hpp"
using namespace std;
/*
   This enum will be replaced in more advanced versions
   with the generated enum from bison
*/

/* These methods are defined below and show how to skip
   comments.
*/
void skipcmnts(void);

/* lexeme of identifier or reserved word */
string tokenString;

/* line number counter */
int lineno = 1;

%}

%option noyywrap

newline     \n
whitespace  [ \t]+

 /* defines digit as any number 0 to 9 */
digit       [0-9]

/* defines num and any combination of 1 or more digits i.e any string of digits */
num         {digit}+

/* defines letter as any lowercase or uppercase letter in the english alphabet */
letter      [a-zA-Z]

/* defines id as a any combination of 1 ore more letters i.e any string of letters */
id          {letter}+

/* Pattern definitions and actions              */
/* patterns are regex expression                */
/* pattern      {What do if pattern is matched} */
%%
{newline}       {lineno++;}
{whitespace}    {/* skip whitespace */}
"/*"            { skipcmnts();}
"else"          {return ELSE;}
"if"            {return IF;}
"int"           {return INT;}
"return"        {return RETURN;}
"void"          {return VOID;}
"while"         {return WHILE;}
"+"             {return PLUS;}
"-"             {return MINUS;}
"*"             {return TIMES;}
"/"             {return OVER;}
"<"             {return LT;}
"<="            {return LE;}
">"             {return GT;}
">="            {return GE;}
"=="            {return EQ;}
"!="            {return NE;}
"="             {return ASSIGN;}
";"             {return SEMI;}
","             {return COMMA;}
"\."            {return DOT;}
"("             {return LPAREN;}
")"             {return RPAREN;}
"["             {return LBRACK;}
"]"             {return RBRACK;}
"{"             {return LBRACE;}
"}"             {return RBRACE;}
{num}           {
                int temp;
                sscanf(yytext, "%d", &temp);
                yylval = new treenode(300, yytext, temp);
                return NUM;
                }

{id}            {
                    yylval = new treenode(400, yytext);
                    return ID;
                }
.               {return ERROR;}


%%


/* Borrowed mostly from TINY.l */
void skipcmnts (void) {
   char previous = '\0';
   char c;
   c = yyinput();
   do
   {
      if (c == EOF) {
         break;
      }
      if (c == '\n') {
         lineno++;
      }
      previous = c;
      c = yyinput();
   } while (previous != '*' || c != '/');

}

