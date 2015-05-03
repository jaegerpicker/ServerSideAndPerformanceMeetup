//
// Created by Shawn Campbell on 4/28/15.
//

#ifndef CASHREGISTERCPP_DENOMINATION_H
#define CASHREGISTERCPP_DENOMINATION_H

#include <string>

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

#endif //CASHREGISTERCPP_DENOMINATION_H
