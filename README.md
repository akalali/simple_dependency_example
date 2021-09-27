## C++ project using CMake to demonstrate library dependencies.

This simple project consists of three libraries and an executable to demonstrate the installation of libraries with transitive dependencies for a main executable.

### How to use this project

Inside the `app`-directory a `CMakeLists.txt`-file is located, which defines an executable and links a library to the target.
This `SimpleLibrary`-dependency is found using `find_package` - however, the path to the `SimpleLibrary` has to be manually specified,
using the `SimpleLibrary_DIR` or `CMAKE_PREFIX_PATH` variable.

For that the `SimpleLibrary` needs to be build and installed. This is done by generating the `SimpleLibrary` project using the `CMakeLists.txt`-file
inside the `libs/simple_library/CMakeLists.txt` directory.
This configuration file defines a library (target `SimpleLibrary`) and specifies rules to install the library to a given prefix-path.
`SimpleLibrary` is linked to the `TwoLibraries` target and thus `TwoLibraries` needs to be build and installed before.
Once this is done the path to the `TwoLibraries` has to be manually specified, using the `TwoLibraries_DIR` or `CMAKE_PREFIX_PATH` variable.

### Installing targets

In order to install libraries and make them available for other projects to link against, install rules have been defined inside the `CMakeLists.txt`:
[CMakeLists.txt](libs/simple_library/CMakeLists.txt#L24) defines the target named `SimpleLibrary` and associates the target with the export, defined as `${PROJECT_NAME}-export`.
Two destinations are given to specificy the path for the target artifacts (static and shared libraries).

[CMakeLists.txt](libs/simple_library/CMakeLists.txt#L30) creates a CMake file containing code to import targets from the installation tree into another project.
The corresponding export was defined in the previous `install`-command. The `FILE` option defines a specific filename for the created CMake file.
A destination is given to specify the path for the created CMake file.

[CMakeLists.txt](libs/simple_library/CMakeLists.txt#L36) copies the project's header file into an output directory inside the install-directory.
This allows to link the target to this header file using [CMakeLists.txt](libs/simple_library/CMakeLists.txt#L13)

[CMakeLists.txt](libs/simple_library/CMakeLists.txt#L41) copies the project's cmake configuration file to an output directory inside the install-directory.
This cmake configuration file will simply include the created `SimpleLibraryTargets.cmake` from [CMakeLists.txt](libs/simple_library/CMakeLists.txt#L31).
This `Config.cmake`-file is used by depending projects to point to the installed dependency (using `find_package` and pointing to this config file using
`SimpleLibrary_DIR` or `CMAKE_PREFIX_PATH`).

All mentioned install-directories are appended to an install prefix, which is typically specified when installing, using
`cmake --install . --prefix <PREFIX_PATH_FOR_INSTALL_DIRECTORY>`.


As seen in [CMakeLists.txt](libs/simple_library/CMakeLists.txt#L4) `SimpleLibrary` is dependent on `TwoLibraries`,
which is configured in [CMakeLists.txt](libs/two_libraries/CMakeLists.txt).
Again, install rules have been defined inside the `CMakeLists.txt`, to define targets, exports and copy required header and cmake configuration files to an output directory
inside the install-directory. There is not much difference to the `SimpleLibrary` cmake configuration file except for two libraries being exported in a single target instead of one library.

### How to build this project

The following commands are an example of how this project can be build:
- for the `two_libraries` subdirectory (building the `TwoLibraries`-library)
  - `cmake <PATH_TO libs/two_libraries>`
  - `cmake --build <PATH_TO_BUILD>`
  - `cmake --install <PATH_TO_BUILD> --prefix <PREFIX_PATH_FOR_INSTALL_DIRECTORY>`

- for the `simple_library` subdirectory (building the `SimpleLibrary`-library)
  - `cmake <PATH_TO libs/simple_libary> -DCMAKE_PREFIX_PATH=<PREFIX_PATH_FOR_INSTALL_DIRECTORY>/cmake`
  - `cmake --build <PATH_TO_BUILD>`
  - `cmake --install <PATH_TO_BUILD> --prefix <PREFIX_PATH_FOR_INSTALL_DIRECTORY>`

This will build the libraries and export the required files to `<PREFIX_PATH_FOR_INSTALL_DIRECTORY>`.

- for the `app` subdirectory (building the `Main`-executable)
  - `cmake <PATH_TO app> -DCMAKE_PREFIX_PATH=<PREFIX_PATH_FOR_INSTALL_DIRECTORY>/cmake`
  - `cmake --build <PATH_TO_BUILD>`

Depending on the used CMake generator it might be necessary to use `cmake --build . --config Release` or `cmake --build . --config Debug`.
