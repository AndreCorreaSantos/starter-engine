#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include "Lexer.h"

using namespace engine;


class Initializer{
public:
    std::string name;
    std::string op_type;
    std::vector<int> shape;
    std::vector<float> data;
};

std::string parse_name(Lexer& lexer) {
    std::string name;
    name = lexer.getId();
    lexer.getNextToken();
    return name;
}

std::vector<int> parse_shape(Lexer& lexer) {
    std::vector<int> shape;
    // Ensure the opening parenthesis is consumed
    lexer.consume(tok_parenthesis_open);

    while (lexer.getCurToken() != tok_parenthesis_close) {
        if (lexer.getCurToken() == tok_number) {
            shape.push_back(lexer.getValue());
            lexer.consume(tok_number);
            if (lexer.getCurToken() == tok_comma) {
                lexer.consume(tok_comma);
            } else if (lexer.getCurToken() != tok_parenthesis_close) {
                throw std::runtime_error("Unexpected token in shape, expected ',' or ')'");
            }
        } else {
            throw std::runtime_error("Unexpected token in shape, expected integer");
        }
    }
    // Ensure the closing parenthesis is consumed
    lexer.consume(tok_parenthesis_close);

    return shape;
}

std::vector<float> parse_data(Lexer& lexer) {
    std::vector<float> data;
    while (lexer.getCurToken() == tok_number){
        data.push_back(lexer.getValue());
        lexer.consume(tok_number);
        Location loc = lexer.getLastLocation();
        if (loc.col > 10){
            return data;
        }
    }
    return data;
}

Initializer parse_initializer(Lexer& lexer){
    std::string name;
    std::string op_type;
    std::vector<int> shape;
    std::vector<float> data;
    name = parse_name(lexer);
    shape = parse_shape(lexer);
    op_type = parse_name(lexer);
    data = parse_data(lexer);
    
    return Initializer{name, op_type, shape, data};
}   

int main(int argc, char* argv[]){

    if(argc != 2){
        std::cout << "Error: Invalid number of arguments" << std::endl;
        return 0;
    }

    Lexer lexer(argv[1]);
    lexer.getNextToken();
    Initializer initializer = parse_initializer(lexer);
    std::cout << initializer.data.back() << std::endl;
    

    return 0;
}