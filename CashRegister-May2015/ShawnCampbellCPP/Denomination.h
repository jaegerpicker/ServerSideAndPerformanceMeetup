//
// Created by Shawn Campbell on 4/28/15.
//

#ifndef CASHREGISTERCPP_DENOMINATION_H
#define CASHREGISTERCPP_DENOMINATION_H

#include <string>

class Denomination {
private:
    std::string denom_name;
    float value;
public:
    std::string getDenomName();
    float getValue();
    void setDenomName(std::string name);
    void setValue(float value);

};


#endif //CASHREGISTERCPP_DENOMINATION_H
