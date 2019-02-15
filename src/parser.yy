/* Copyright (C) Khudyashev Ivan, 2019, bahek1983@gmail.com */
%skeleton "lalr1.cc"
%require "3.2"
%language "c++"
%define api.namespace {test}

%code requires {
    namespace test {
        class lexer;
    }
}

%parse-param {test::lexer& reflex_lexer}

%code {
    #include <iostream>
    #include "lexer.hpp"
    #undef yylex
    #define yylex reflex_lexer.yylex
}
/* Define Tokens */
%right P_ASSIGN
%left P_LAND
%left P_EQ
%left P_ADD P_SUB
%left P_MUL P_DIV
%left P_USUB
%left P_INC P_DEC

%precedence KW_IF
%precedence KW_ELSE

%token LINETERMINATOR
%token KW_DUMMYOP
%token P_SEMI
%token P_LBRACE
%token P_RBRACE
%token L_NULL
%token L_TRUE
%token L_FALSE
%token L_NUMERIC
%token L_STRING
%token L_REGEX
%token IDENTIFIER
%token T_UNDEFINED
%token T_END

%%
root: batch T_END
 {
    std::cout << "Successfully parsed!" << std::endl;
    return 0;
 }
 ;

batch: stmt P_SEMI
 | batch stmt P_SEMI
 ;

stmt: if_stmt
 | expr
 ;

if_stmt: KW_IF if_expr stmt KW_ELSE stmt
 { std::cout<< "If-Then-Else" << std::endl; }
 | KW_IF if_expr stmt
 { std::cout << "If-Then" << std::endl; }
 ;

if_expr: P_LBRACE expr P_RBRACE
 ;

expr: prim
 { std:: cout << "expr: prim" << std::endl; }
 | P_DEC prim
 { std:: cout << "expr: --" << std::endl; }
 | P_INC prim
 { std:: cout << "expr: ++" << std::endl; }
 | expr P_ADD expr
 { std:: cout << "expr: +" << std::endl; }
 | expr P_SUB expr
 { std:: cout << "expr: -" << std::endl; }
 | expr P_MUL expr
 { std:: cout << "expr: *" << std::endl; }
 | expr P_DIV expr
 { std:: cout << "expr: /" << std::endl; }
 | expr P_LAND expr
 { std:: cout << "expr: &&" << std::endl; }
 | expr P_EQ expr
 { std:: cout << "expr: ==" << std::endl; }
 | prim P_ASSIGN expr
 { std:: cout << "expr: assign" << std::endl; }
 | P_SUB expr %prec P_USUB
 { std:: cout << "expr: unary minus" << std::endl; }
 ;

prim: IDENTIFIER
 | literal
 ;

 /*
stmt_terminator: P_SEMI
 | line_ter P_SEMI
 ;

line_ter: LINETERMINATOR
 | line_ter LINETERMINATOR
 ;
 */
literal: L_NULL
 | L_TRUE
 | L_FALSE
 | L_NUMERIC
 | L_STRING
 ;
%%
void test::parser::error(const std::string& msg)
{
    /*std::cout << "Error: " << msg << std::endl;*/
}
