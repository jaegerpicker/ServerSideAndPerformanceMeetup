//
// Created by Shawn Campbell on 4/28/15.
//

#include "Denomination.h"

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