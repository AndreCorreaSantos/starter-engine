#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include "Lexer.h"
#include <string_view>
using namespace engine;


class Initializer{
public:
    std::string name;
    std::vector<int> shape;
    std::vector<float> data;
};

std::string parse_name(Lexer& lexer, bool consume = true) {
    std::string name;
    name = lexer.getId();
    if(consume){
        lexer.getNextToken();
    }
    return name;
}

std::vector<int> parse_shape(Lexer& lexer, bool consume = true) {
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
    if(lexer.getCurToken() != tok_parenthesis_close){
        throw std::runtime_error("Expected closing parenthesis");
    }

    if(consume){
        lexer.consume(tok_parenthesis_close);
    }

    return shape;
}


std::vector<float> splitString(const std::string& input, char delimiter) {
    std::vector<float> result;
    size_t start = 0;
    size_t end;

    while ((end = input.find(delimiter, start)) != std::string::npos) {
        result.push_back(strtod(input.substr(start, end - start).c_str(), nullptr));
        start = end + 1;
    }
    // Add the last token
    result.push_back(strtod(input.substr(start).c_str(),nullptr));
    
    return result;
}


std::vector<float> parse_data(Lexer& lexer) {
    std::vector<float> data = splitString(lexer.getLineBuffer(), ' ');
    lexer.getNextLine();
    lexer.getNextToken();
    return data;
}

Initializer parse_initializer(Lexer& lexer){
    std::string name;
    std::vector<int> shape;
    std::vector<float> data;
    name = parse_name(lexer);
    shape = parse_shape(lexer,false);
    data = parse_data(lexer);
    
    return Initializer{name, shape, data};
}   

int main(int argc, char* argv[]){

    if(argc != 2){
        std::cout << "Error: Invalid number of arguments" << std::endl;
        return 0;
    }

    Lexer lexer(argv[1]);
    lexer.getNextToken();
    


    Initializer initializer1 = parse_initializer(lexer);
    Initializer initializer2 = parse_initializer(lexer);
    std::cout << initializer2.name << std::endl;
    std::cout<< initializer2.data.front() << std::endl;
    std::cout << initializer2.data.back() << std::endl;
    std::cout << initializer2.data.size() << std::endl;

    return 0;
}