#include <iostream>
#include <fstream>
#include <string>

using namespace std;

int main(int argc, char** argv) {

    string infilePath, outfilePath;
    
    // Determines filename from argument
    if (argc == 3) {
        infilePath = argv[1];
        outfilePath = argv[2];
    } else {
        cout << "Please enter filename after executable." << endl;
        return 0;
    }
    
    

    ofstream outfile;
    outfile.open (outfilePath);

}

class csv {

    string* header;

    // numRows does not include header row
    int numCols, numRows;
    string** data;

    csv(string path, bool hasHeader) {

        // Create file reader
        ifstream infile;
        infile.open (path);

        // Create file header
        if (hasHeader) {

        }

    }

};