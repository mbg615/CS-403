#include <cmath>
#include <string>
#include <vector>
#include <sstream>
#include <iomanip>

#include "Cylinder.h"
#include "../comp.h"


Cylinder::Cylinder(std::string name, double r, double h) : Shape(name), radius(r), height(h) {}

double Cylinder::getArea() const {
    return (2 * M_PI * radius * height) + (2 * M_PI * std::pow(radius, 2));
}

double Cylinder::getVolume() const {
    return M_PI * std::pow(radius, 2) * height;
}

std::string Cylinder::getInfo() const {
    std::ostringstream oss;
    oss << std::fixed << std::setprecision(2);

    oss << "Cylinder: " << getName() <<
        ", Radius=" << radius <<
        ", Height=" << height <<
        "\n\tSurface Area: " << this->getArea() <<
        ", Volume=" << this->getVolume();

    return oss.str();
}

bool Cylinder::test(const std::vector<std::string> &cond) const {
    for(int i = 0; i < cond.size(); i+=3) {
        if(!compare(cond[i], cond[i+1], cond[i+2], getArea(), getVolume(), "cylinder")) return false;
    }

    return true;
}
