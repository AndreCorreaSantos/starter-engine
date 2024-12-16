#include <cstdlib>
#include <memory>
#include <string>
#include <cassert>
#include <math.h> 
namespace engine {


enum Token : int {
    tok_parenthesis_open = '(',
    tok_parenthesis_close = ')',
    tok_colon = ':',
    tok_comma = ',',

    tok_identifier = -5,
    tok_number = -4,
    tok_eof = -1,
};

/// Structure definition a location in a file.
struct Location {
  std::shared_ptr<std::string> file; ///< filename.
  int line;                          ///< line number.
  int col;                           ///< column number.
};

class Lexer {
public:
    Lexer(std::string filename)
        : lastLocation({std::make_shared<std::string>(std::move(filename)), 0, 0}),
          fileStream(*lastLocation.file) 
    {
        if (!fileStream.is_open())
            throw std::runtime_error("Could not open file: " + *lastLocation.file);
        
        // Initialize the current line buffer with the first line
        curLineBuffer = readNextLine();
    }

    Token getCurToken() { return curTok; }

    Token getNextToken() {return curTok = getTok();};
    /// Move to the next token in the stream, asserting on the current token
    /// matching the expectation.
    void consume(Token tok) {
        assert(tok == curTok && "consume Token mismatch expectation");
        getNextToken();
    }

    /// Return the current identifier (prereq: getCurToken() == tok_identifier)
    std::string getId() {
        assert(curTok == tok_identifier);
        return identifierStr;
    }

    /// Return the current number (prereq: getCurToken() == tok_number)
    double getValue() {
        assert(curTok == tok_number);
        return numVal;
    }

    std::string getLineBuffer() { return curLineBuffer; }

    void getNextLine() {
        curLineBuffer = readNextLine();
        curLineNum++;
        curCol = 0;
    }

    // DEBUGGING FUNCS

    /// Return the location for the beginning of the current token.
    Location getLastLocation() { return lastLocation; }

    // Return the current line in the file.
    int getLine() { return curLineNum; }

    // Return the current column in the file.
    int getCol() { return curCol; }



private:
    std::string readNextLine() {
        std::string line;
        if (std::getline(fileStream, line)) {
            line.push_back('\n');
            return line;
        }
        return std::string();
    }


    int getNextChar() {
        // The current line buffer should not be empty unless it is the end of file.
        if (curLineBuffer.empty())
        return EOF;
        ++curCol;
        auto nextchar = curLineBuffer.front();
        curLineBuffer = curLineBuffer.erase(0, 1);
        if (curLineBuffer.empty())
        curLineBuffer = readNextLine();
        if (nextchar == '\n') {
        ++curLineNum;
        curCol = 0;
        }
        return nextchar;
    }

    ///  Return the next token from standard input.
    Token getTok() {
        // Skip any whitespace.
        while (isspace(lastChar))
        lastChar = Token(getNextChar());

        // Save the current location before reading the token characters.
        lastLocation.line = curLineNum;
        lastLocation.col = curCol;

        // Identifier: [a-zA-Z][a-zA-Z0-9_]*
        if (isalpha(lastChar)) {
        identifierStr = (char)lastChar;
        while (isalnum((lastChar = Token(getNextChar()))) || lastChar == '_' || lastChar == '.')
            identifierStr += (char)lastChar;

        return tok_identifier;
        }

        // Number: [0-9.]+
        if (isdigit(lastChar) || lastChar == '.' || lastChar == '-' || lastChar == '+') {
            std::string numStr;
            do {
                numStr += lastChar;
                lastChar = Token(getNextChar());
            } while (isdigit(lastChar) || lastChar == '.' || lastChar == 'e' || lastChar == 'E' || lastChar == '-' || lastChar == '+');

            numVal = strtod(numStr.c_str(), nullptr);
            return tok_number;
        }

        if (lastChar == '#') {
        // Comment until end of line.
        do {
            lastChar = Token(getNextChar());
        } while (lastChar != EOF && lastChar != '\n' && lastChar != '\r');

        if (lastChar != EOF)
            return getTok();
        }

        // Check for end of file.  Don't eat the EOF.
        if (lastChar == EOF)
        return tok_eof;

        // Otherwise, just return the character as its ascii value.
        Token thisChar = Token(lastChar);
        lastChar = Token(getNextChar());
        return thisChar;
    }
    /// The last token read from the input.
    Token curTok = tok_eof;

    /// Location for `curTok`.
    Location lastLocation;

    /// If the current Token is an identifier, this string contains the value.
    std::string identifierStr;

    /// If the current Token is a number, this contains the value.
    double numVal = 0;

    /// The last value returned by getNextChar(). We need to keep it around as we
    /// always need to read ahead one character to decide when to end a token and
    /// we can't put it back in the stream after reading from it.
    Token lastChar = Token(' ');

    /// Keep track of the current line number in the input stream
    int curLineNum = 0;

    /// Keep track of the current column number in the input stream
    int curCol = 0;

    /// Buffer supplied by the derived class on calls to `readNextLine()`
    std::string curLineBuffer = "\n";

    std::ifstream fileStream;

};



}