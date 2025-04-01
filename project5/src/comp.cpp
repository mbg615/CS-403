#include <string>
#include <cstdlib>

#include "comp.h"

bool compare(std::string name, std::string op, std::string value, double area, double volume, std::string type) {
    if (name == "type") {
        if (op == "==") return type == value;
        if (op == "!=") return type != value;
        if (op == "<") return type < value;
        if (op == ">") return type > value;
        if (op == "<=") return type <= value;
        if (op == ">=") return type >= value;
    }
    else if (name == "area") {
        double refValue = std::stod(value);
        if (op == "==") return area == refValue;
        if (op == "!=") return area != refValue;
        if (op == "<") return area < refValue;
        if (op == ">") return area > refValue;
        if (op == "<=") return area <= refValue;
        if (op == ">=") return area >= refValue;
    }
    else if (name == "volume") {
        double refValue = std::stod(value);
        if (op == "==") return volume == refValue;
        if (op == "!=") return volume != refValue;
        if (op == "<") return volume < refValue;
        if (op == ">") return volume > refValue;
        if (op == "<=") return volume <= refValue;
        if (op == ">=") return volume >= refValue;
    }

    return false;
}
