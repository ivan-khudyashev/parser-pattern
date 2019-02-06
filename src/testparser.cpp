#include <iostream>
#include "parser.hpp"
#include "lexer.hpp"

int main()
{
    test::lexer l;
    test::parser p(l);
    int ret_val = p();
    std::cout << "Parsing result = " << ret_val << std::endl;
    return ret_val;
}
