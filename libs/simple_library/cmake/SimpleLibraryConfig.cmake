include(CMakeFindDependencyMacro)

find_dependency(TwoLibraries REQUIRED)

include("${CMAKE_CURRENT_LIST_DIR}/SimpleLibraryTargets.cmake")