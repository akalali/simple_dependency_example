#----------
# Main-Application
#----------

cmake_minimum_required(VERSION 3.18)
project(App VERSION 1.0.0 LANGUAGES CXX)

find_package(SimpleLibrary REQUIRED)

add_executable(Main src/main.cpp)

target_link_libraries(Main
	PRIVATE SimpleLibrary::SimpleLibrary
)
