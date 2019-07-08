%skeleton "lalr1.cc" /* -*- C++ -*- */
%require "3.2" /*current version on 42 Macintosh*/
%defines

%define api.token.constructor
%define api.value.type variant
%define parse.assert

%code requires {
	# include <iostream>
	# include <string>
	# include "Operand.hpp"
	class Driver;
}
%param { Driver &drv }
%locations

%define parse.trace
%define parse.error verbose

%code {
	# include "Driver.hpp"
}


%define api.token.prefix {TOK_}
/* miscellaneous parsing tokens */
%token
	END		0	"end of file"
	SEP			"separator"
	COMMENT		"comment"
	MY_EOF		"my_eof"
	LPAREN		"("
	RPAREN		")"

/* instructions */
%token
	PUSH	"push"
	POP		"pop"
	DUMP	"dump"
	ASSERT	"assert"
	ADD		"add"
	SUB		"sub"
	MUL		"mul"
	DIV		"div"
	MOD		"mod"
	PRINT	"print"
	EXIT	"exit"

/* Type specifiers for operands */
%token
	INT8			"int8"
	INT16			"int16"
	INT32			"int32"
	FLOAT			"float"
	DOUBLE			"double"

/* literal values (from the lexer) */
%token <std::string> FLOAT_VALUE	"float_value"
%token <std::string> INT_VALUE		"int_value"

%type <OperandType> type
%type <std::string> literal
%type <Operand*> value
%type <void*> instruction

%printer { yyo << $$; } <*>;

%%
%start input;

input:
	%empty { }
	| instruction SEP input		{ drv.pushInstruction($1); }
	| COMMENT SEP input { }
	| MY_EOF { }
	;

instruction:
	PUSH value		{ std::cout << "this is a push\n"; delete $2; $$ = nullptr;/*new Push($2);*/ }
	| POP			{ std::cout << "this is a pop\n"; $$ = nullptr;/*new Pop();*/ }
	| DUMP			{ std::cout << "this is a Dump\n"; $$ = nullptr;/*new Dum();*/ }
	| ASSERT value	{ std::cout << "this is a assert\n"; delete $2; $$ = nullptr;/*new Assert($2);*/ }
	| ADD			{ std::cout << "this is a add\n"; $$ = nullptr;/*new Add();*/ }
	| SUB			{ std::cout << "this is a sub\n"; $$ = nullptr;/*new Sub();*/ }
	| MUL			{ std::cout << "this is a mul\n"; $$ = nullptr;/*new Mul();*/ }
	| DIV			{ std::cout << "this is a div\n"; $$ = nullptr;/*new Div();*/ }
	| MOD			{ std::cout << "this is a mod\n"; $$ = nullptr;/*new Mod();*/ }
	| PRINT			{ std::cout << "this is a print\n"; $$ = nullptr;/*new Print();*/ }
	| EXIT			{ std::cout << "this is a exit\n"; $$ = nullptr;/*new Exit();*/ }
	| instruction COMMENT { $$ = $1; }
	;

value:
	type LPAREN literal RPAREN	{ $$ = new Operand(Operand::StrToOperand($3, $1)); }
	;

literal:
	INT_VALUE		{ $$ = $1; }
	| FLOAT_VALUE	{ $$ = $1; }
	;

type:
	INT8		{ $$ = OperandType::Int8; }
	| INT16		{ $$ = OperandType::Int16; }
	| INT32		{ $$ = OperandType::Int32; }
	| FLOAT		{ $$ = OperandType::Float; }
	| DOUBLE	{ $$ = OperandType::Double; }
	;


%%

void
yy::parser::error (const location_type& l, const std::string& m)
{
  std::cerr << l << ": " << m << '\n';
}
/*
int	main(void)
{
	yyparse();
}*/