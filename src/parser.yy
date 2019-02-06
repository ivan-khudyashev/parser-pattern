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

%token LINETERMINATOR
%token P_SEMI
%token L_NULL
%token L_TRUE
%token L_FALSE
%token L_NUMERIC
%token L_STRING
%token IDENTIFIER
%token T_UNDEFINED
%token T_END

%%
root: batch T_END
 {
    std::cout << "Successfully parsed!" << std::endl;
 }
 ;

batch: stmt stmt_terminator
 | batch stmt stmt_terminator
 ;

stmt: IDENTIFIER
 | literal
 ;

stmt_terminator: P_SEMI
 | line_ter
 ;

line_ter: LINETERMINATOR
 | line_ter LINETERMINATOR
 ;

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
