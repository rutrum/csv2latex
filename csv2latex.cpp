#include <iostream>
#include <fstream>
#include <string>
#include <stdio.h>
#include <vector>

using namespace std;

class csv {

    vector< vector<string> > data;

public:

    csv(string path) {

        // Create file reader
        ifstream infile(path);

        if (!infile.good()) {
            // File not found
            cout << "That file does not exist." << endl;
            return;
        }

        parse(infile);

        infile.close();

    }

    void print() {
        for (int i = 0; i < data.size(); i++) {
            for (int j = 0; j < data[i].size(); j++) {
                cout << data[i][j] << " ";
            }
            cout << endl;
        }
    }

    vector< vector<string> > getData() {
        return data;
    }

private: 

    void parse(ifstream& infile) {
        string line;
        while (getline(infile, line)) {
            data.push_back(split(line));
        }
    }

    vector<string> split(string line) {
        vector<string> cols;

        int index = line.find(",");
        while (index != -1) {

            // Find value and reset index
            string value = line.substr(0, index);
            line.erase(0, index+1);
            index = line.find(",");

            // Store value in vector
            cols.push_back(value);
        }

        cols.push_back(line);
        return cols;
    }

};

class latex {

    vector< vector<string> > data;

public:

    latex(string path, vector< vector<string> > data) {
        this->data = data;

        ofstream outfile;
        outfile.open (path);

        outfile.close();

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
    CSV.print();

}