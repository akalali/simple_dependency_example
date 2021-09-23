cmake_minimum_required(VERSION 3.18)
project(TwoLibraries VERSION 1.0.0 LANGUAGES CXX)

#---------------------#
# define libraries and target
#---------------------#
add_library(LibraryA src/LibraryA.cpp)

target_include_directories(LibraryA PUBLIC
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
	$<INSTALL_INTERFACE:include/${PROJECT_NAME}>
)

add_library(LibraryB src/LibraryB.cpp)

target_include_directories(LibraryB PUBLIC
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
	$<INSTALL_INTERFACE:include/${PROJECT_NAME}>
)

#---------------------#
# install files and target
#---------------------#
install(TARGETS LibraryA LibraryB
	EXPORT ${PROJECT_NAME}-export
	LIBRARY DESTINATION lib/${PROJECT_NAME}
	ARCHIVE DESTINATION lib/${PROJECT_NAME}
)

install(EXPORT ${PROJECT_NAME}-export
	FILE ${PROJECT_NAME}Targets.cmake
	NAMESPACE ${PROJECT_NAME}::
	DESTINATION cmake/${PROJECT_NAME}
)

install(FILES
	${CMAKE_CURRENT_SOURCE_DIR}/include/LibraryA.h
	${CMAKE_CURRENT_SOURCE_DIR}/include/LibraryB.h
	DESTINATION include/${PROJECT_NAME}
)

install(FILES
	${CMAKE_CURRENT_SOURCE_DIR}/cmake/${PROJECT_NAME}Config.cmake
	DESTINATION cmake/${PROJECT_NAME}
)
