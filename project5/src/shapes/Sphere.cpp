#include <cmath>
#include <string>
#include <vector>
#include <sstream>
#include <iomanip>

#include "Sphere.h"
#include "../comp.h"


Sphere::Sphere(std::string name, double r) : Shape(name), radius(r) {}

double Sphere::getArea() const {
    return 4 * M_PI * std::pow(radius, 2);
}

double Sphere::getVolume() const {
    return (4.0 / 3.0) * M_PI * std::pow(radius, 3);
}

std::string Sphere::getInfo() const {
    std::ostringstream oss;
    oss << std::fixed << std::setprecision(2);

    oss << "Sphere: " << getName() <<
        ", Radius=" << radius <<
        "\n\tSurface Area: " << this->getArea() <<
        ", Volume=" << this->getVolume();

    return oss.str();
}

bool Sphere::test(const std::vector<std::string> &cond) const {
    for(int i = 0; i < cond.size(); i+=3) {
        if(!compare(cond[i], cond[i+1], cond[i+2], getArea(), getVolume(), "sphere")) return false;
    }

    return true;
}
