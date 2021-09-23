#include "SimpleLibrary.h"
#include <iostream>

int main()
{
  SimpleLibrary simpleLib;
  std::cout << "Printing all linked libraries\n";
  simpleLib.printAll();
  return 0;
}
