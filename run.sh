#!/bin/bash

# compiling two_libraries
cd ./libs/two_libraries
mkdir build
cmake -S . -B build/
cmake --build build/
cmake --install build/ --prefix /home/tfoerst/libs/cmake_ex_2libs

# compiling simple_libraries
# it depends on two_libraries
cd ..
cd simple_library
mkdir build
cmake -S . -B build/ -D CMAKE_PREFIX_PATH="/home/tfoerst/libs/cmake_ex_2libs/cmake"
cmake --build build/
cmake --install build/ --prefix /home/tfoerst/libs/cmake_ex_1lib


# compiling the executable
cd ../../app/
mkdir build
cmake -S . -B build/
cmake -S . -B build/ -D CMAKE_PREFIX_PATH="/home/tfoerst/libs/cmake_ex_2libs/cmake;/home/tfoerst/libs/cmake_ex_1lib/SimpleLibrary/cmake"
cmake --build build/

./build/Main
