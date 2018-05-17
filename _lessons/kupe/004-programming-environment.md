---
layout: post
title:  Programming Environment
permalink: /lessons/kupe-programming-environment/
chapter: kupe
---

You will learn how to compile code on Kupe.

## Getting the code examples

To access the code examples:

```
git clone https://github.com/nesi/hpc_training.git
```

Then go to the `code` directory:

```
cd hpc_training/code
```

There are further subdirectories with the different examples that will be shown in this session.

### Targeting a CPU

A CPU target should be loaded before building any code. This means that you tell the compiler to use instructions that are understood by this particular CPU (or a younger CPU of the same family). Otherwise you will see a warning message from the Cray compiler driver whenever you try to compile code,

```
No supported cpu target is set, CRAY_CPU_TARGET=x86-64 will be used.
Load a valid targeting module or set CRAY_CPU_TARGET
```

Although the compilers will still work, the resulting code is generic code for x86-64 processors and not optimised for the Skylake processor. So be sure to load
```
module load craype-x86-skylake
```
The resulting executable will not run on older processors, such as the Broadwell family which is used for the upcoming HPC1. Codes will either crash with an "illegal instruction" error, or display an error message if built with an Intel compiler.

### Compiler Drivers

The Cray environment provides compiler drivers (wrapper scripts for the actual compilers), which should be used to compile Fortran, C, and C++ code:

```
ftn -o simpleMpi simpleMpi.f90 # compile Fortran code
cc -o simpleMpi simpleMpi.c    # compile C code
CC -o simpleMpi simpleMpi.cxx  # compile C++ code
```

The drivers will ensure correct linking of your code with compiler runtime libraries, and with Cray-supported libraries (such as Cray's `libsci` scientific library, or netCDF). We will get to that topic later in this session.

There is no need to invoke special compilers for MPI code or to apply special compiler options for code with OpenMP directives - use ```ftn```, ```cc```, and ```CC``` in all cases.

Note that running an MPI code on the build (`elogin`) node using
```
./simpleMpi
```
will fail with an error message, as there is no MPI runtime environment:
```
[Wed Oct 18 02:00:14 2017] [c0-0c0s3n1] Fatal error in MPI_Init: Other MPI error, error stack:
MPIR_Init_thread(537):
MPID_Init(247).......: channel initialization failed
MPID_Init(636).......:  PMI2 init failed: 1
```
SLURM offers an `mpiexec` command that submits your program to the compute nodes on the fly, but this may not be supported in the future.

### Programming environments

The default programming environment provides Cray's CCE (Cray Compiler Environment) for Fortran, C, and C++. However, other compilers can also be selected using

```
module swap PrgEnv-cray PrgEnv-intel
```
to use the _Intel_ compilers, or
```
module swap PrgEnv-cray PrgEnv-gnu
```
to use the _GNU_ compilers. Note that several GNU compiler versions are currently installed (gcc/4.9.3, gcc/5.3.0, gcc/6.1.0 and gcc/7.1.0) - you
switch between the different version by swapping the appropriate modules, e.g.,

```
module swap gcc/4.9.3 gcc/7.1.0
```
You'll need to load GCC v6.1.0 or later if you set the `craype-x86-skylake` environment, otherwise you'll get error messages of the kind
```
craype-x86-skylake requires cce/8.6 or later, intel/15.1 or later, or gcc/6.1 or later
```
Alternatively, you can switch to the `craype-broadwell` target:
```
module swap craype-x86-skylake craype-broadwell
```
You should _always_ invoke the ```ftn```, ```cc``` and ```CC``` compiler drivers to ensure correct linking, regardless of the programming environment.

Note that swapping programming environments will automatically swap Cray-provided libraries - but this will **not** be the case for libraries provided by NeSI or NIWA.

### Common compiler options

Although the compiler drivers ```ftn```, ```cc``` and ```CC``` have a few options of their own, they will pass through any additional compiler options to the underlying compiler. For example, if you are using the `gfortran` compiler and wanted to activate compiler warnings (-Wall) and aggressive compiler optimisation (-O3), you would use the following command:

```
module swap PrgEnv-cray PrgEnv-gnu
ftn -Wall -O3 -o simpleMpi simpleMpi.f90
```

#### Adding debug information

```Cray compiler```: basic debug information are added by default. Depending on the applied optimization (inlining, vectorization, etc.) the debug information can vary. You can select specific debugging options using one of ```-G{0,1,2,fast}```. Note, when specifying ```-g``` without any specific optimization option (-O2 is default), oprimizations are disabled. Otherwise -g is ignored. 

```Gnu/Intel compiler```: you should add ```-g``` to the compiler options. This will add debug information to the executables and/or library you are building.  You can mix optimisation with ```-g```, i.e. ```-O2 -g``` although adding ```-O2``` might prevent the debugger from diving into loops. 

Note: there are quite some more specific debugging options you can select. Please have a look into the compiler man pages (e.g. crayftn, gfortran, ifort). 


#### Optimisation options

Following are a few options that can potentially improve the speed of your executable (same options for ftn, CC and cc):

 * PrgEnv-gnu: ```-O3 -ffast-math -funroll-loops```
 * PrgEnv-cray: ```-O3 -hfp3```
 * PrgEnv-intel: ```-O3 -ipo```

#### Vectorisation report options

 * PrgEnv-gnu: ```-fopt-info-vec``` or ```-fopt-info-missed```
 * PrgEnv-cray: ```-hlist=m```
 * PrgEnv-intel: ```-opt-vec```

To see the compiler options that are specific to a compiler, type
```
man crayftn
man icc
man g++
```
for instance - don't forget to to load the corresponding programming environment first. Here are a few links to compiler documentation:

* Cray Compiler Environment: [Cray Fortran v8.5](http://docs.cray.com/PDF/Cray_Fortran_Reference_Manual_85.pdf), [Cray C and C++ v8.5](http://docs.cray.com/PDF/Cray_C_and_Cplusplus_Reference_Manual_85.pdf)
* Intel compilers: [Intel Fortran Compiler v17.0](https://software.intel.com/sites/default/files/managed/93/88/PDF%20Fortran%20Compiler%20UG%2017.0%3D1%3DSSG%202.0%20PDF%3Den-US.pdf), [Intel C and C++ Compiler v17.0](https://software.intel.com/sites/default/files/managed/08/ac/PDF%20C%2B%2B%20Compiler%20UG%2017.0%3D1%3DSSG%202.0%20PDF%3Den-US.pdf)
* GNU compilers: [GCC C and C++ v4.9.4](https://gcc.gnu.org/onlinedocs/gcc-4.9.4/gcc.pdf), [GCC C and C++ v7.2.0](https://gcc.gnu.org/onlinedocs/gcc-7.2.0/gcc.pdf), [GNU Fortran v4.9.4](https://gcc.gnu.org/onlinedocs/gcc-4.9.4/gfortran.pdf), [GNU Fortran v7.2](https://gcc.gnu.org/onlinedocs/gcc-7.2.0/gfortran.pdf)

The drivers provide their own options, and a few options that are common across programming environments. You can look at them using
```
man ftn
man cc
man CC
```


## Linking against an external library

Three different cases need to be considered for linking your code against an external library:

1. The library is provided by Cray

In this case, it is sufficient to simply load the library module before building your code,
```
module load cray-netcdf
ftn -o simple_xy_wr simple_xy_wr.f90
```
for instance. The compiler drivers ensure that include files and libraries are automatically found, no paths or library flags need to be specified. Moreover, correct libraries will automatically be used when a different compiler is selected (e.g., Intel or GNU).

Note that you may occasionally see a warning message of the kind:
```
/opt/cray/pe/hdf5/1.10.1.1/INTEL/16.0/lib/libhdf5.a(H5PL.o): In function `H5PL_load':
H5PL.c:(.text+0x612): warning: Using 'dlopen' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
```
This simply means that the library must be accessible at runtime despite fully static linking; this can usually be ignored.

Let's have a look at how the compiler driver does this:
```
ftn -o simple_xy_wr simple_xy_wr.f90 -craype-verbose
```
This will produce lots of output, and we will find that the driver added a lot of compiler flags for us.

Let

Run
```
module avail
```
and look for modules that start with "cray-" to get a full list of Cray-provided libraries. Use Cray's libsci or Intel's MKL if you need BLAS, LAPACK, or FFT.

2. The library is provided via NeSI or NIWA

NeSI and NIWA use EasyBuild to provide additional, commonly used libraries. In many cases, loading the library module before building your code will suffice to make it visible to the compiler driver. This example requires the `PrgEnv-gnu` environment, and the `craype-x86-skylake` target is not supported; run
```
module swap craype-x86-skylake craype-broadwell
module swap PrgEnv-cray PrgEnv-gnu
```
before you continue (you may need to replace `PrgEnv-cray` with `PrgEnv-intel` if you worked with the Intel environment before). You should then be able to use the GSL library in the following example:
```
module load GSL/2.4-CrayGNU-2017.06
cc -o gsl_statistics_example gsl_statistics_example.c -lgsl
```
Note that we had to add `-lgsl` to avoid a linker error, but we did not set an additional include path using `-I/some/path/to/gsl/include`, nor a library search path using `-L/some/path/to/gsl/lib`. The GSL module sets the ```CPATH```, ```LIBRARY_PATH```, and ```LD_LIBRARY_PATH``` variables for us, which are picked up by the compiler driver:
```
echo $CPATH
echo $LIBRARY_PATH
echo $LD_LIBRARY_PATH
```
This automatic setup does **not** work in case of the Cray compiler, unfortunately. You will need to help things along a little bit by specifying paths manually using EasyBuild's automatically defined module variables. These can be found by running the `module show` command:
```
module swap PrgEnv-gnu PrgEnv-cray
module load grib_api/1.23.1-CrayCCE-2017.06
cc -I$EBROOTGRIB_API/include -o grib_example grib_example.c -L$EBROOTGRIB_API/lib -lgrib_api
```
EasyBuild's convention for the variable names is `EBROOT<package name>`.

**Note:** Make sure that you choose the correct variant of a library, depending on your choice of compiler. This does *not* happen automatically for libraries that are provided by NeSI and NIWA, and you will also need to swap between different library variants if you swap compilers.

EasyBuild uses the following module naming conventions ("toolchain names"):
* "CrayCCE" for libraries and tools built with the Cray compilers ("PrgEnv-cray")
* "CrayIntel" for libraries and tools built with the Intel compilers ("PrgEnv-intel")
* "CrayGNU" for libraries and tools built with the GNU compilers ("PrgEnv-gnu")

3. You need to link against your own library

In this case, you will need to specify the include or Fortran module files with the ```-I``` option. Use ```-L```
to specify the location of the libraries and ```-l``` the name of the libraries. Libraries typically have the prefix ```lib``` and either ```.so``` or ```.a``` as suffix.  Do not include the lib prefix or the suffix when passing a library name to the ```-l``` option. For instance, library "A" might be called ```libA.a``` and to link against "A" you would use ```-lA```.

You can have multiple ```-L``` and ```-l``` options. When specifying libraries with ```-l```, the order matters. Symbols are resolved from left to right; that is if library "A" depends on "B" then "A" should precede "B" (```-lA -lB```). Library "A" depends on "B" if "A" calls functions or invokes symbols that are defined in "B".

### Static and dynamic linking

The compilers drivers default to static linking where possible, and the resulting executables will be completely self-contained if all dependencies are available as static libraries. Let's have a look at the previous example:
```
cc -o gsl_statistics_example gsl_statistics_example.c -lgsl
ldd gsl_statistics_example
```
This should result in the message `not a dynamic executable`. Static linking is recommended on XC systems for performance reasons. To force dynamic linking, run the following command:
```
cc -o gsl_statistics_example gsl_statistics_example.c -lgsl -dynamic
ldd gsl_statistics_example
```
You should now see a number of libraries that are dynamically linked. Note that not all libraries are available as both static and dynamic libraries - in this case, the linker will simple use what it can get.
