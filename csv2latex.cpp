#include <iostream>
#include <fstream>
#include <string>
#include <stdio.h>

using namespace std;

class csv {

    string* header;

    // numRows does not include header row
    int numCols, numRows;
    string** data;

public:

    csv(string path) {

        // Create file reader
        ifstream infile(path);

        if (!infile.good()) {
            // File not found
            cout << "That file does not exist." << endl;
            return;
        }

        string line;
        while (getline(infile, line)) {
            cout << line << endl;
            split(line);
        }
        infile.close();

    }

private: 

    void split(string line) {
        int index = line.find(",");
        while (index != -1) {
            string value = line.substr(0, index);
            cout << value << endl;
            line.erase(0, index+1);
            index = line.find(",");
        }
        cout << line << endl;
    }

};

int main(int argc, char** argv) {

    string infilePath, outfilePath;
    
    // Determines filename from argument
    if (argc == 3) {
        infilePath = argv[1];
        outfilePath = argv[2];
    } else {
        cout << "Please enter input file and output " << endl 
             << "name after executable." << endl;
        return 0;
    }

    csv CSV(infilePath);

}