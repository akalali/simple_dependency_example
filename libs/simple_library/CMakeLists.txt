cmake_minimum_required(VERSION 3.18)
project(SimpleLibrary VERSION 1.0.0 LANGUAGES CXX)

find_package(TwoLibraries CONFIG REQUIRED)

#---------------------#
# define librariy and target
#---------------------#
add_library(${PROJECT_NAME} src/SimpleLibrary.cpp)

target_include_directories(${PROJECT_NAME} PUBLIC
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
	$<INSTALL_INTERFACE:include/${PROJECT_NAME}>
)

target_link_libraries(${PROJECT_NAME}
	PUBLIC TwoLibraries::LibraryA
	PUBLIC TwoLibraries::LibraryB
)

#---------------------#
# install files and target
#---------------------#
install(TARGETS ${PROJECT_NAME}
	EXPORT ${PROJECT_NAME}-export
	LIBRARY DESTINATION lib/${PROJECT_NAME}
	ARCHIVE DESTINATION lib/${PROJECT_NAME}
)

install(EXPORT ${PROJECT_NAME}-export
	FILE SimpleLibraryTargets.cmake
	NAMESPACE ${PROJECT_NAME}::
	DESTINATION cmake/${PROJECT_NAME}
)

install(FILES
	${CMAKE_CURRENT_SOURCE_DIR}/include/${PROJECT_NAME}.h
	DESTINATION include/${PROJECT_NAME}
)

install(FILES
	${CMAKE_CURRENT_SOURCE_DIR}/cmake/${PROJECT_NAME}Config.cmake
	DESTINATION cmake/${PROJECT_NAME}
)
