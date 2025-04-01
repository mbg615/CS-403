#ifndef PROJECT5_BOX_H
#define PROJECT5_BOX_H

#include <string>

#include "../Shape.h"

class Box : public Shape {
private:
    double length;
    double width;
    double height;

public:
    Box(std::string name, double l, double w, double h);

    double getArea() const;

    double getVolume() const;

    bool test(const std::vector<std::string>& cond) const;

    std::string getInfo() const;
};

#endif //PROJECT5_BOX_H
