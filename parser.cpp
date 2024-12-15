#include <iostream>
#include <fstream>
#include <string>
using namespace std;



void initializer(){
    // read string
    // re
}


int main(int argc, char* argv[]){

    if(argc != 2){
        cout << "Error: Invalid number of arguments" << endl;
        return 0;
    }

    string word;
    ifstream file(argv[1]);

    if(!file.is_open()){
        cout << "Error: File not found" << endl;
        return 0;
    }

    // read token
    while(file >> word){
    
    }



    return 0;
}