#ifndef PROJECT5_TORUS_H
#define PROJECT5_TORUS_H

#include "../Shape.h"

class Torus : public Shape {
private:
    double smallRadius;
    double bigRadius;

public:
    Torus(std::string name, double sr, double br);

    double getArea() const;

    double getVolume() const;

    bool test(const std::vector<std::string>& cond) const;

    std::string getInfo() const;

};

#endif //PROJECT5_TORUS_H
