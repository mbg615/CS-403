#include <cmath>
#include <string>
#include <vector>
#include <sstream>
#include <iomanip>

#include "Torus.h"
#include "../comp.h"


Torus::Torus(std::string name, double sr, double br) : Shape(name), smallRadius(sr), bigRadius(br) {}

double Torus::getArea() const {
    return 2 * M_PI * bigRadius * 2 * M_PI * smallRadius;
}

double Torus::getVolume() const {
    return M_PI * std::pow(smallRadius, 2) * 2 * M_PI * bigRadius;
}

std::string Torus::getInfo() const {
    std::ostringstream oss;
    oss << std::fixed << std::setprecision(2);

    oss << "Torus: " << getName() <<
        ", Small Radius=" << smallRadius <<
        ", Big Radiu=" << bigRadius <<
        "\n\tSurface Area: " << this->getArea() <<
        ", Volume=" << this->getVolume();

    return oss.str();
}

bool Torus::test(const std::vector<std::string> &cond) const {
    for(int i = 0; i < cond.size(); i+=3) {
        if(!compare(cond[i], cond[i+1], cond[i+2], getArea(), getVolume(), "torus")) return false;
    }

    return true;
}
