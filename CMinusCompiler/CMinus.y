/*
    Tanner Smith, 10/14/2021
    Project 3 Part 1 Parser for CSCI 440
    This file is a bison file that defines grammar rules for the cminus language.
    This file gets compiled into a hpp/ccp set of files that will parse the grammar
    rules of the cminus coding language.
*/

/****************************************************/
/* File: CMinus.y                                   */
/* The CMinus Bison specification file              */
/* Grammar from: Compiler Construction: Principles  */
/* and Practice.                                    */
/*                                                  */
/* There are currently no actions associated with   */
/* any of the rules, so running this program        */
/* on correct C- programs generates no output.      */
/*                                                  */
/* To compile create your parser                    */
/* make                                             */
/*                                                  */
/* ./parse < cminusfilename                         */
/*                                                  */
/* Stuart Hansen                                    */
/* January 2018                                     */
/****************************************************/

%{
#include <iostream>
#include <string>
#include "common.h"
using namespace std;

int yylex();
int yyerror(string message);
treenode * root;
extern char* yytext;
extern int lineno;

%}

/* book-keeping tokens */
%token   ENDFILE ERROR

/* reserved words */
%token    ELSE IF INT RETURN VOID WHILE

/* special symbols */
%token    PLUS MINUS TIMES OVER LT LE GT GE EQ NE ASSIGN
%token    SEMI COMMA DOT LPAREN RPAREN LBRACK RBRACK LBRACE RBRACE

/* Comment tokens, currently not used */
%token    LCOMMENT RCOMMENT

/* multicharacter tokens */
%token    ID NUM

%% /* Grammar for CMinus 
      Complete this section for Assignment 3 */
		/* rule 10 */
program 		: declarationList  {root = $1;}
		;
		/* rule 20 */
declarationList		: declarationList declaration
{
 $$ = $1;
 $$->addChild($2);
}
			| declaration
{
$$ = new treenode(21, "decl list");
$$->addChild($1);
}
		;
		/* rule 30 */
declaration		: varDeclaration
{
$$ = new treenode(30, "var declaration");
$$->addChild($1);
}
			| funcDeclaration
{
$$ = new treenode(31, "func declaration");
$$->addChild($1);
}
		;
		/* rule 40 */
varDeclaration		: typeSpecifier ID SEMI
{
$$ = new treenode(40, $2->getText(), $1->getType());
}
			| typeSpecifier ID LBRACK NUM RBRACK SEMI
{
$$ = new treenode(41, $2->getText(), $1->getType() + "[]", $4->getIntValue());
}
		;
		/* rule 50 */
typeSpecifier		: INT
{
$$ = new treenode(50, "typeSpecifer", "int");
}
			| VOID
{
$$ = new treenode(51, "typeSpecifer", "void");
}
		;
		/* rule 60 */
funcDeclaration		: typeSpecifier ID LPAREN params RPAREN compoundStatement
{
$$ = new treenode(60, $2->getText(), $1->getType());
$$->addChild($4);
$$->addChild($6);
}
		;
		/* rule 70 */
params			: paramList
{
$$ = $1;
}
			| VOID
{
$$ = new treenode(71, "", "void");
}
		;
		/* rule 80 */
paramList		: paramList COMMA param
{
$$ = $1;
$$->addChild($3);
}
			| param
{
$$ = new treenode(81, "paramList");
$$->addChild($1);
}
		;
		/* rule 90 */
param			: typeSpecifier ID
{
$$ = new treenode(90, $2->getText(), $1->getType());
}
			| typeSpecifier ID LBRACK RBRACK
{
$$ = new treenode(91, $2->getText(), $1->getType() + "[]");
}
		;
		/* rule 100 */
compoundStatement	: LBRACE localDeclarations statementList RBRACE
{
$$ = new treenode(100, "compound statement");
$$->addChild($2);
$$->addChild($3);
}
		;
		/* rule 110 */
localDeclarations	: localDeclarations varDeclaration
{
$$ = $1;
$$->addChild($2);
}
			| //empty
{
$$ = new treenode(111, "localDeclarations");
}
		;
		/* rule 120 */
statementList		: statementList statement
{
$$ = $1;
$$-> addChild($2);
}
			| //empty
{
$$ = new treenode(121, "statementList");
}
		;
		/* rule 130 */
statement		: expressionStatement
{
$$ = $1;
}
			| compoundStatement
{
$$ = $1;
}
			| selectionStatement
{
$$ = $1;
}
			| iterationStatement
{
$$ = $1;
}
			| returnStatement
{
$$ = $1;
}
		;
		/* rule 140 */
expressionStatement	: expression SEMI
{
$$ = new treenode(140, "expression statement");
$$->addChild($1);
}
			| SEMI
{
$$ = new treenode(141, "empty expression statement");
}
		;
		/* rule 150 */
selectionStatement	: IF LPAREN expression RPAREN statement
{
$$ = new treenode(150, "if statement");
$$->addChild($3);
$$->addChild($5);
}
			| IF LPAREN expression RPAREN statement ELSE statement
{
$$ = new treenode(151, "if...else statement");
$$->addChild($3);
$$->addChild($5);
$$->addChild($7);
}
		;
		/* rule 160 */
iterationStatement	: WHILE LPAREN expression RPAREN statement
{
$$ = new treenode(160, "while statement");
$$->addChild($3);
$$->addChild($5);
}
		;
		/* rule 170 */
returnStatement		: RETURN SEMI
{
$$ = new treenode(170, "return");
}
			| RETURN expression SEMI
{
$$ = new treenode(171, "return with value");
$$->addChild($2);
}
		;
		/* rule 180 */
expression		: var ASSIGN expression
{
$$ = new treenode(180, "expression");
$$->addChild($1);
$$->addChild($3);
}
			| simpleExpression
{
$$ = new treenode(181, "expression");
$$->addChild($1);
}
		;
		/* rule 190 */
var			: ID
{
$$ = new treenode(190, "var");
$$->addChild($1);
}
			| ID LBRACK expression RBRACK
{
$$ = new treenode(191, "var");
$$->addChild($1);
$$->addChild($3);
}
		;
		/* rule 200 */
simpleExpression	: additiveExpression relop additiveExpression
{
$$ = new treenode(200, "simple expression");
$$->addChild($1);
$$->addChild($2);
$$->addChild($3);
}
			| additiveExpression
{
$$ = new treenode(201, "simple expression");
$$->addChild($1);
}
		;
		/* rule 210 */
relop			: LE	/* <= */
{
$$ = new treenode(210, "<=");
}
			| LT	/* < */
{
$$ = new treenode(211, "<");
}
			| GT	/* > */
{
$$ = new treenode(212, ">");
}
			| GE	/* >= */
{
$$ = new treenode(213, ">=");
}
			| EQ 	/* == */
{
$$ = new treenode(214, "==");
}
			| NE	/* != */
{
$$ = new treenode(215, "!=");
}
		;
		/* rule 220 */
additiveExpression	: additiveExpression addop term
{
$$ = new treenode(220, "additive expression");
$$->addChild($1);
$$->addChild($2);
$$->addChild($3);
}
			| term
{
$$ = new treenode(221, "additive expression");
$$-> addChild($1);
}
		;
		/* rule 230 */
addop			: PLUS
{
$$ = new treenode(230, "+");
}
			| MINUS
{
$$ = new treenode(231, "-");
}
		;
		/* rule 240 */
term			: term mulop factor
{
$$ = new treenode(240, "term");
$$->addChild($1);
$$->addChild($2);
$$->addChild($3);
}
			| factor
{
$$ = new treenode(241, "term");
$$->addChild($1);
}
		;
		/* rule 250 */
mulop			: TIMES
{
$$ = new treenode(250, "*");
}
			| OVER
{
$$ = new treenode(251, "/");
}
		;
		/* rule 260 */
factor			: LPAREN expression RPAREN
{
$$ = new treenode(260, "factor");
$$->addChild($2);
}
			| var
{
$$ = new treenode(261, "factor");
$$->addChild($1);
}
			| call
{
$$ = new treenode(262, "factor");
$$->addChild($1);
}
			| NUM
{
$$ = new treenode(263, "factor");
$$->addChild($1);
}
		;
		/* rule 270 */
call			: ID LPAREN args RPAREN
{
$$ = new treenode(270, "call");
$$->addChild($3);
}
		;
		/* rule 280 */
args			: argList
{
$$ = new treenode(280, "args");
$$->addChild($1);
}
			| //empty
{
$$ = new treenode(281, "no args");
}
		;
		/* rule 290 */
argList			: argList COMMA expression
{
$$ = $1;
$$->addChild($3);
}
			| expression
{
$$ = new treenode(291, "args list");
$$->addChild($1);
}
		;



%%

/*
  Dumbed down version of yyerror, mostly borrowed from TINY.y
*/
int yyerror(string message)
{
  cout << "Syntax error at line: " << lineno << " " << message << endl;
  return 0;
}

/*
  Can't get a much simpler main
int main() {
   yyparse();
   return 0;
}
*/

