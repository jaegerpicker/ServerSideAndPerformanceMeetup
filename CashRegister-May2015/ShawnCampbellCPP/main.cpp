#include <map>
#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>


using namespace std;

class Denomination {
private:
    std::string denom_name;
    float value;
public:
    std::string getDenomName();
    float getValue();
    void setDenomName(std::string name);
    void setValue(float value);
    Denomination(std::string name, float value);

};

void Denomination::setValue(float value) {
    this->value = value;
}

std::string Denomination::getDenomName() {
    return this->denom_name;
}

void Denomination::setDenomName(std::string name) {
    this->denom_name = name;
}

float Denomination::getValue() {
    return this->value;
}

Denomination::Denomination(std::string name, float value) {
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


string build_output(float val, map<float, Denomination*>* denom_list, string output) {
    for(map<float, Denomination*>::reverse_iterator it = denom_list->rbegin(); it != denom_list->rend(); ++it) {
        if(it->first < val || it->first == val) {
            output += it->second->getDenomName();
            val = val - it->first;
            if(val < 0.01) {
                break;
            } else {
                output += ",";
            }
        }
    }

    return output;
}

int main(int argc, char * argv[]) {
    map<float, Denomination*> denom_list;
    Denomination * penny = new Denomination("PENNY", 0.01);
    denom_list[penny->getValue()] = penny;
    Denomination * nickel = new Denomination("NICKEL", 0.05);
    denom_list[nickel->getValue()] = nickel;
    Denomination * dime = new Denomination("DIME", 0.10);
    denom_list[dime->getValue()] = dime;
    Denomination * quarter = new Denomination("QUARTER", 0.25);
    denom_list[quarter->getValue()] = quarter;
    Denomination * half_dollar = new Denomination("HALF DOLLAR", 0.50);
    denom_list[half_dollar->getValue()] = half_dollar;
    Denomination * one = new Denomination("ONE", 1.00);
    denom_list[one->getValue()] = one;
    Denomination * two = new Denomination("TWO", 2.00);
    denom_list[two->getValue()] = two;
    Denomination * five = new Denomination("FIVE", 5.00);
    denom_list[five->getValue()] = five;
    Denomination * ten = new Denomination("TEN", 10.00);
    denom_list[ten->getValue()] = ten;
    Denomination * twenty = new Denomination("TWENTY", 20.00);
    denom_list[twenty->getValue()] = twenty;
    Denomination * fifty = new Denomination("FIFTY", 50.00);
    denom_list[fifty->getValue()] = fifty;
    Denomination * one_hundred = new Denomination("ONE HUNDRED", 100.00);
    denom_list[one_hundred->getValue()] = one_hundred;
    ifstream stream(argv[1]);
    string line;
    while(getline(stream, line)) {
        string output = "";
        vector<string> vals = split(line, ';');
        float val1 = stof(vals[0]);
        float val2 = stof(vals[1]);
        if(val1 < val2 ) {
            output = build_output(val2 - val1, &denom_list, output);
        } else if(val1 == val2) {
            output = "ZERO";
        } else {
            output = "ERROR";
        }
        cout << output << endl;
        output = "";
    }
    return 0;
}

