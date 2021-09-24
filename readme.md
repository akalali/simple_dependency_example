# Compiling process

- First you need to compile and install __two_libraries__
- Second you need to compile and install __simple_library__
- Last you can compile your executable

## Compiling in a `bash`

You need to have _cmake_ installed. The instructions are stored in `run.sh`.

In the `run.sh` you need to change `user=<user_name>` to your user name.

### Library 'two_libraries':

~~~ bash
cd ./libs/two_libraries
mkdir build
cmake -S . -B build/
cmake --build build/
cmake --install build/ --prefix /home/<user>/libs/cmake_ex_2libs
~~~

### Library 'simple_libraries':

~~~
cd ..
cd simple_library
mkdir build
cmake -S . -B build/ -D CMAKE_PREFIX_PATH="/home/<user>/libs/cmake_ex_2libs/cmake"
cmake --build build/
cmake --install build/ --prefix /home/<user>/libs/cmake_ex_1lib
~~~

### Executable 'Main'

~~~
cd ../../app/
mkdir build
cmake -S . -B build/
cmake -S . -B build/ -D CMAKE_PREFIX_PATH="/home/<user>/libs/cmake_ex_2libs/cmake;/home/<user>/libs/cmake_ex_1lib/cmake"
~~~

