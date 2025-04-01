//
// Created by Maddox Guthrie on 3/10/25.
//

#ifndef PROJECT5_SPHERE_H
#define PROJECT5_SPHERE_H

#include <string>
#include <vector>

#include "../Shape.h"

class Sphere : public Shape {
private:
    double radius;

public:
    Sphere(std::string name, double r);

    double getArea() const;

    double getVolume() const;

    bool test(const std::vector<std::string>& cond) const;

    std::string getInfo() const;

};

#endif //PROJECT5_SPHERE_H
