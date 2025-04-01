#ifndef PROJECT5_CYLINDER_H
#define PROJECT5_CYLINDER_H

#include "../Shape.h"

class Cylinder : public Shape {
private:
    double radius;
    double height;

public:
    Cylinder(std::string name, double r, double h);

    double getArea() const;

    double getVolume() const;

    bool test(const std::vector<std::string>& cond) const;

    std::string getInfo() const;

};

#endif //PROJECT5_CYLINDER_H
