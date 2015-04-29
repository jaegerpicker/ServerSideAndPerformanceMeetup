//
// Created by Shawn Campbell on 4/28/15.
//

#include "Denomination.h"

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
