
cmake_minimum_required(VERSION 2.8.5)

project(cpp_fortran)

enable_language(Fortran)

add_library(clib clib.c)
add_executable(cpp_fortran main.f90)
target_link_libraries(cpp_fortran clib)
