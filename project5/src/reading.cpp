#include <vector>
#include <string>
#include <fstream>
#include <sstream>

#include "reading.h"
#include "shapes/Box.h"
#include "shapes/Cylinder.h"
#include "shapes/Sphere.h"
#include "shapes/Torus.h"


std::vector<Shape*> *readFrom(std::string fileName) {
    std::ifstream dataFile(fileName);
    std::vector<Shape*> *shapes = new std::vector<Shape*>();

    if(!dataFile) return shapes;

    std::string line;
    while(std::getline(dataFile, line)) {
        if(line.empty()) continue;

        std::istringstream stream(line);
        std::string shapeName;
        std::string shapeType;

        stream >> shapeName;
        stream >> shapeType;

        if(shapeType == "box") {
            double l, w, h;
            if(stream >> l >> w >> h) shapes->push_back(new Box(shapeName, l, w, h));
            continue;
        }

        if(shapeType == "cylinder") {
            double r, h;
            if(stream >> r >> h) shapes->push_back(new Cylinder(shapeName, r, h));
            continue;
        }

        if(shapeType == "sphere") {
            double r;
            if(stream >> r) shapes->push_back(new Sphere(shapeName, r));
            continue;
        }

        if(shapeType == "torus") {
            double sr, br;
            if(stream >> sr >> br) shapes->push_back(new Torus(shapeName, sr, br));
        }
    }

    dataFile.close();
    return shapes;
}
