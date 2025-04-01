#include <string>
#include <vector>
#include <sstream>
#include <iomanip>

#include "Box.h"
#include "../comp.h"


Box::Box(std::string name, double l, double w, double h) : Shape(name), length(l), width(w), height(h) {}

double Box::getArea() const {
    return 2 * (length * width + width * height + height * length);
}

double Box::getVolume() const {
    return length * width * height;
}

std::string Box::getInfo() const {
    std::ostringstream oss;
    oss << std::fixed << std::setprecision(2);

    oss << "Box: " << getName() <<
           ", Length=" << length <<
           ", Width=" << width <<
           ", Height=" << height <<
           "\n\tSurface Area: " << this->getArea() <<
           ", Volume=" << this->getVolume();

    return oss.str();
}

bool Box::test(const std::vector<std::string> &cond) const {
    for(int i = 0; i < cond.size(); i+=3) {
        if(!compare(cond[i], cond[i+1], cond[i+2], getArea(), getVolume(), "box")) return false;
    }

    return true;
}
