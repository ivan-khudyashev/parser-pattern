#include <iostream>
#include "parser.hpp"
#include "lexer.hpp"

using TToken = test::parser::token_type;

const char* token_type(TToken t);

int main(void)
{
    test::lexer l;
    test::parser::semantic_type lvl;
    TToken t;
    while((t = static_cast<TToken>(l.yylex(lvl))) != TToken::T_END) {
        std::cout << "\tToken type: " << token_type(t) << std::endl;
    }

    return 0;
}
