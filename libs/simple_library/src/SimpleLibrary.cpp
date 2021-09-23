#include "SimpleLibrary.h"
#include "LibraryA.h"
#include "LibraryB.h"
#include <iostream>

void SimpleLibrary::printAll()
{
  LibraryA libA;
  LibraryB libB;
  std::cout << "Class name is SimpleLibrary\n";
  std::cout << "Included class name is:\n";
  libA.printClassName();
  std::cout << "Included class name is:\n";
  libB.printClassName();
}
