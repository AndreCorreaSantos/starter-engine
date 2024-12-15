#include <iostream>
#include <fstream>
#include <string>
#include "Lexer.h"

using namespace engine;


// std::string read_file(const std::string& filename){
//     std::ifstream file(filename);

//     if(!file.is_open()){
//         std::cout << "Error: File not found" << std::endl;
//         return "error";
//     }
//     std::string content((std::istreambuf_iterator<char>(file)), std::istreambuf_iterator<char>());
//     return content;
// }





int main(int argc, char* argv[]){

    if(argc != 2){
        std::cout << "Error: Invalid number of arguments" << std::endl;
        return 0;
    }

    Lexer lexer(argv[1]);
    Token tok;

    lexer.getNextToken();

    std::cout << "Token: " << lexer.getCurToken() << std::endl;
    std::cout << lexer.getId() << std::endl;

    

    return 0;
}