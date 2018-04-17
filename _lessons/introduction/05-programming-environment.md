---
layout: post
title: Programming environment
permalink: /lessons/introduction/programming-environment/
chapter: introduction
---

# The material below is just copied from Pan materials - needs work to adapt to new platforms

## Compiling code on NeSI platforms

Cray provides compiler wrappers, which should be used to compile Fortran, C and C++ code:

```
ftn -o simpleMpiF90 simpleMpi.f90 # compile Fortran code
cc -o simpleMpiC simpleMpi.c      # compile C code
CC -o simpleMpiCxx simpleMpi.cxx  # compile C++ code
```

There is no need to invoke special compilers for MPI code or to apply special compiler options for code with OpenMP directives - use ftn, cc, and CC
in all cases.

### Programming environments

The default programming environment provides ```cray``` compilers; however, other compilers can also be selected using

```
module swap PrgEnv-cray PrgEnv-intel
```
to use the Intel compilers, or
```
module swap PrgEnv-cray PrgEnv-gnu
```
to use the GNU compilers.

### Common compiler options

The list of compiler options differs for each programming environment. To type get the list of common options across programming environments, type for instance
```
man ftn
```
To see the compiler options that are specific to a compiler, type
```
man crayftn
```
for instance.

### Targeting a particular CPU

When running on Skylake processors, be sure to load
```
module load craype-x86-skylake
```

### Linking against an external library

In general, you will need to specify the include or module files with the ```-I``` option and link against one of more libraries. Use ```-L```
to specify the location of the libraries and ```-l``` the name of the libraries. Do not include You can have multiple ```-L``` and ```-l``` options. When specifying libraries with ```-l```, the order matters. Symbols are resolved from left to right; that is if library "A" depends on "B" then "A" should precede "B" (```-lA -lB```). Library "A" depends on "B" if "A" calls functions or invokes symbols that are defined in "B".

There is no need to link code explicitly to the LAPACK and BLAS libraries.


#### Example: Linking against NetCDF

```
module load cray-netcdf cray-hdf5
ftn -o simple_xy_par_wr -I$NETCDF_DIR/include simple_xy_par_wr.f90 \
    -L$NETCDF_DIR/lib -L$HDF5_DIR/lib \
    -lnetcdff -lnetcdf -lhdf5_hl_parallel -lhdf5_parallel
```

Note that some modules will automatically set the additional compiler options so that users don't have to specify include and library directories or library names. For the example above it suffices to type
```
ftn -o simple_xy_par_wr simple_xy_par_wr.f90
```
