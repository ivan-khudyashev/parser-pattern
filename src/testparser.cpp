#include <iostream>
#include "parser.hpp"
#include "lexer.hpp"

int main()
{
    test::lexer l;
    test::parser p(l);
    int ret_val = 0;
    std::cout << "Init value of ret_val = " << ret_val << std::endl;
    ret_val = p.parse();
    std::cout << "Parsing result = " << ret_val << std::endl;
    return ret_val;
}
