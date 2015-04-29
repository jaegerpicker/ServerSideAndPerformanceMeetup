#include <iostream>
#include "Denomination.h"

using namespace std;

int main() {
    Denomination * denom = new Denomination();
    denom->setValue(1.2);
    denom->setDenomName("test");
    cout << "Hello, World! " << denom->getDenomName() << " is worth " << denom->getValue() << endl;
    return 0;
}