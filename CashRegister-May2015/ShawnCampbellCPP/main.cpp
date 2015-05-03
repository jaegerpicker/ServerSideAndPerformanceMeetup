#include <map>
#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <algorithm>


using namespace std;

class Denomination {
private:
    std::string denom_name;
    int value;
public:
    std::string getDenomName();
    int getValue();
    void setDenomName(std::string name);
    void setValue(int value);
    Denomination(std::string name, int value);

};

void Denomination::setValue(int value) {
    this->value = value;
}

std::string Denomination::getDenomName() {
    return this->denom_name;
}

void Denomination::setDenomName(std::string name) {
    this->denom_name = name;
}

int Denomination::getValue() {
    return this->value;
}

Denomination::Denomination(std::string name, int value) {
    this->setDenomName(name);
    this->setValue(value);
}

vector<string> &split(const string &s, char delimiter, vector<string> &elems) {
    stringstream ss(s);
    string item;
    while(getline(ss, item, delimiter)){
        elems.push_back(item);
    }
    return elems;
}

vector<string> split(const string &s, char delimiter ) {
    vector<string> elems;
    split(s, delimiter, elems);
    return elems;
}


string build_output(int val, map<int, Denomination*>* denom_list, string output) {
    int test_val = 0;
    int first_val = val;
    for(map<int, Denomination*>::reverse_iterator it = denom_list->rbegin(); it != denom_list->rend(); ++it) {
        if(it->first < val || it->first == val) {
            output += it->second->getDenomName();
            test_val += it->first;
            val = val - it->first;
            while(val >= it->first) {
                val = val - it->first;
                test_val += it->first;
                output += "," + it->second->getDenomName();
            }
            if(val < 1) {
                break;
            } else {
                output += ",";
            }
        }
    }
    char buffer[50];
    sprintf(buffer, "%d %d", test_val, first_val);
    //cout << buffer << endl;
    //assert(test_val == first_val);
    if(output.substr(output.size()-1, 1) == ",") {
        return output.substr(0, output.size() - 1);
    } else {
        return output;
    }
}

int main(int argc, char * argv[]) {
    map<int, Denomination*> denom_list;
    Denomination * penny = new Denomination("PENNY", 1);
    denom_list[penny->getValue()] = penny;
    Denomination * nickel = new Denomination("NICKEL", 5);
    denom_list[nickel->getValue()] = nickel;
    Denomination * dime = new Denomination("DIME", 10);
    denom_list[dime->getValue()] = dime;
    Denomination * quarter = new Denomination("QUARTER", 25);
    denom_list[quarter->getValue()] = quarter;
    Denomination * half_dollar = new Denomination("HALF DOLLAR", 50);
    denom_list[half_dollar->getValue()] = half_dollar;
    Denomination * one = new Denomination("ONE", 100);
    denom_list[one->getValue()] = one;
    Denomination * two = new Denomination("TWO", 200);
    denom_list[two->getValue()] = two;
    Denomination * five = new Denomination("FIVE", 500);
    denom_list[five->getValue()] = five;
    Denomination * ten = new Denomination("TEN", 1000);
    denom_list[ten->getValue()] = ten;
    Denomination * twenty = new Denomination("TWENTY", 2000);
    denom_list[twenty->getValue()] = twenty;
    Denomination * fifty = new Denomination("FIFTY", 5000);
    denom_list[fifty->getValue()] = fifty;
    Denomination * one_hundred = new Denomination("ONE HUNDRED", 10000);
    denom_list[one_hundred->getValue()] = one_hundred;
    ifstream stream(argv[1]);
    string line;
    while(getline(stream, line)) {
        string output = "";
        vector<string> vals = split(line, ';');
        int val1 = 0;
        int val2 = 0;
        if(vals[0].find(".") != string::npos) {
            vals[0].erase(remove(vals[0].begin(), vals[0].end(), '.'), vals[0].end());
            val1 = stoi( vals[0] );//int(stof(vals[0]) * 100);
        } else {
            val1 = stoi(vals[0]) * 100;
        }
        if(vals[1].find(".") != string::npos) {
            vals[1].erase(remove(vals[1].begin(), vals[1].end(), '.'), vals[1].end());
            val2 = stoi(vals[1]);
        } else {
            val2 = stoi(vals[1]) * 100;
        }
        if(val1 < val2 ) {
            output = build_output(val2 - val1, &denom_list, output);
        } else if(val1 == val2) {
            output = "ZERO";
        } else {
            output = "ERROR";
        }
        cout << output << endl;
    }
    return 0;
}

