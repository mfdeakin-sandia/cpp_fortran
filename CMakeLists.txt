
cmake_minimum_required(VERSION 2.8.5)

project(cpp_fortran)

enable_language(Fortran)

get_filename_component(Fortran_COMPILER_NAME ${CMAKE_Fortran_COMPILER} NAME)

if(Fortran_COMPILER_NAME MATCHES "gfortran.*")
  # gfortran
  set(CMAKE_Fortran_FLAGS_RELEASE "-funroll-all-loops -fno-f2c -O3")
  set(CMAKE_Fortran_FLAGS_DEBUG   "-fno-f2c -O0 -g")
elseif(Fortran_COMPILER_NAME MATCHES "ifort.*")
  # ifort (untested)
  set(CMAKE_Fortran_FLAGS_RELEASE "-f77rtl -O3")
  set(CMAKE_Fortran_FLAGS_DEBUG   "-f77rtl -O0 -g")
elseif(Fortran_COMPILER_NAME MATCHES "g77")
  # g77
  set(CMAKE_Fortran_FLAGS_RELEASE "-funroll-all-loops -fno-f2c -O3 -m32")
  set(CMAKE_Fortran_FLAGS_DEBUG   "-fno-f2c -O0 -g -m32")
else(Fortran_COMPILER_NAME MATCHES "gfortran.*")
  message("CMAKE_Fortran_COMPILER full path: " ${CMAKE_Fortran_COMPILER})
  message("Fortran compiler: " ${Fortran_COMPILER_NAME})
  message("No optimized Fortran compiler flags are known, we just try -O2...")
  set(CMAKE_Fortran_FLAGS_RELEASE "-O2")
  set(CMAKE_Fortran_FLAGS_DEBUG   "-O0 -g")
endif(Fortran_COMPILER_NAME MATCHES "gfortran.*")

message("CMAKE_CXX_COMPILER_ID: ${CMAKE_CXX_COMPILER_ID}")

find_package(OpenMP)

if(OPENMP_FOUND)
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OpenMP_C_FLAGS}")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
  set(CMAKE_Fortran_FLAGS_DEBUG "${CMAKE_Fortran_FLAGS_DEBUG} ${OpenMP_C_FLAGS}")
  set(CMAKE_Fortran_FLAGS_RELEASE "${CMAKE_Fortran_FLAGS_RELEASE} ${OpenMP_C_FLAGS}")
endif()

add_library(clib clib.c)
add_executable(cpp_fortran main.f90)
target_link_libraries(cpp_fortran clib)
