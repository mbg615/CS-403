# Compiler
CXX = g++
CXXFLAGS = -Wall -std=c++11 -g

# Target executable
TARGET = a.out

# Source files
SRCS = src/main.cpp \
       src/reading.cpp \
       src/shapes/Box.cpp \
       src/shapes/Cylinder.cpp \
       src/shapes/Sphere.cpp \
       src/shapes/Torus.cpp \
       src/Shape.cpp \
       src/comp.cpp

# Object files
OBJS = $(SRCS:.cpp=.o)

# Default target
all: $(TARGET)

# Link the executable
$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) $(OBJS) -o $(TARGET)

# Compile each source file into an object file
%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Clean build files
clean:
	rm -f $(OBJS) $(TARGET)
