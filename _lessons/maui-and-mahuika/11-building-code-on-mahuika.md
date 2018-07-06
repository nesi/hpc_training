---
layout: post
title: Building code on Mahuika - the Cray CS Programming Environment
permalink: /lessons/maui-and-mahuika/building-code-mahuika
chapter: maui-and-mahuika
---

## Objectives

You will learn:

* how to compile code (Fortran, C, C++) 
* how to link against libraries
* using the Cray Programming Environment (compiler drivers)

The example programs used in this lesson can be found in the  [_code](https://github.com/nesi/hpc_training/tree/gh-pages/_code) directory of the "hpc_training" repository.

**Content is still under development. Check back soon.**

## Where to build
Build processes can be performed on the Mahuika login nodes, ```login.mahuika.nesi.org.nz```. Please be aware, that these login nodes are limited and shared resources. Please limit the amount of processes on these nodes (avoid `make -j`, instead use `make -j 5`). Larger build processes should be performed from a compute node. Thus you can also ask for larger amount of compute resources to build your. 

## Compiler and library modules
Compilers of three different vendors are provided on Mahuika: CRAY, GNU, INTEL. The Cray compiler has some special features, which are briefly noted at section [Cray Programming Environment](#cray-programming-environment). 
These compilers and their version can be selected by loading the related module (see table below). 
Often additional libraries are necessary required for compilation. Most common libraries are installed on the system, e.g. libraries for MPI, parallel IO, and mathematical calculations. Some libraries are already provided by the operation system (e.g. libc), other come along with the compiler (e.g. OpenMP). Additional libraries are provided by the module environment. Some oft them are loaded automatically, some can be added manually. 

|Compiler | module | related MPI | Note |
|---------|--------|-----|------|
|CRAY | ```PrgEnv-cray``` | ```cray-mvapich2``` |specific (MPI and scientific) libraries are loaded **automatically** |
|INTEL | ```intel``` | ```impi``` | specific (MPI and MKL) libraries are loaded **automatically** |
|GNU | ```GCC``` |  ```OpenMPI``` | libraries need to be loaded **manually** |

For example, the Cray compiler with FFTW support can be enabled by:
```
  module load PrgEnv-cray cray-fftw
```

If necessary also a specific compiler version can be loaded or changed, e.g.
```
module load gcc/6.1.0
```
Or
```
module swap gcc gcc/7.1.0
```

## Compilers
Compilers are provided for Fortran, C, and C++. For MPI parallelized code often different compilers need to be used. The different **compilers** are listed: 

| Language | CRAY | INTEL | GNU |
| ---------|------|-------|-----|
| Fortran       | ftn | ifort | gfortran|
| Fortran + MPI | ftn | mpiifort | mpifort |
| C             | cc | icc | gcc |
| C + MPI       | cc | mpiicc | mpicc |
| C++           | CC | icpc | gxx |
| C++ + MPI     | CC | mpiicpc | mpicxx |

**Note**, Cray uses compiler wrapper which are described [later in more detail](#cray-programming-environment). 

In general you then compile your code using:
```
  <compiler> <arguments> <source-file>
```
e.g.
``` 
  ftn -O3 hello.f90
```

## Compiler options
Compilers are controlled using different options to control optimizations, output, source and library handling. There options vary between the different compiler vendors. That means you will need to change them if you decide to switch compilers.
The following table provides a list of commonly used compiler **options** for the different compilers:

| Group         | Cray | Intel | GNU | Notes   |
|---------------|------|-------|-----|---------|
| Debugging | ```-g``` or ```-G{0,1,2,fast}``` | ```-g``` or ```-debug [keyword]``` | ```-g or -g{0,1,2,3}``` | Set level of debugging information, some levels may disable certain compiler optimisations |
| Light compiler optimisation  | ```-O2``` | ```-O2``` | ```-O2``` | |
| Aggressive compiler optimisation  | ```-O3 -hfp3``` | ```-O3 -ipo``` | ```-O3 -ffast-math -funroll-loops``` | This may affect numerical accuracy |
| Vectorisation reports | ```-hlist=m``` | ```-qopt-report``` | ```-fopt-info-vec``` or ```-fopt-info-missed``` | |
| OpenMP | ```-homp``` (default) | ```-openmp``` | ```-fopenmp``` | |

Additional compiler options are documented in the compiler man pages, e.g. ```man mpicc```, which are available *after* loading the related compiler module. Additional documentation can be also found at the vendor web pages:

- [Cray Fortran v8.7](https://pubs.cray.com/content/S-3901/8.7/cray-fortran-reference-manual/fortran-compiler-introduction), [Cray C and C++ v8.7](https://pubs.cray.com/content/S-2179/8.7/cray-c-and-c++-reference-manual/invoke-the-c-and-c++-compilers)
- [Intel Developer Guides](https://software.intel.com/en-us/documentation/view-all?search_api_views_fulltext=&current_page=0&value=78151,83039;20813,80605,79893,20812,20902;20816;20802;20804)
- [GCC Manuals](https://gcc.gnu.org/onlinedocs/)

<!-- so far no intel man pages available, need to be fixed [https://nznesi.atlassian.net/browse/POPS-247] -->
**Note**: Cray uses compiler wrappers, to list the compiler options, you need to view man pages of the actual compiler.

For example, the following commands would be used to compile with the gfortran compiler, activate compiler warnings (```-Wall```), and requiring aggressive compiler optimisation (```-O3```):
```
module load gcc openmpi/gcc
mpifort -Wall -O3 -o simpleMpi simpleMpi.f90
```

## Linking
Beside of some basic libraries like glibc and MPI, additional libraries need to be specified manually. In general one need to specify: 

 - header file location, using the option ```-I /path/to/headers```
 - library location, using ```-L /path/to/lib/```
 - library name, usually formatted as, ```-l<library name>```
 
Thus the linker expects to find the include headers in the */path/to/headers* and the library at */path/to/lib/lib<library name>.so* (we assume dynamic linking).

Note that you may need to list several libraries to link successfully, e.g., ```-lA -lB``` for linking against libraries "A" and "B". The order in which you list libraries matters, as the linker will go through the list in order of appearance. If library "A" depends on library "B", specifying ```-lA -lB``` will work. If library "B" depends on "A", use ```-lB -lA```. If they depend on each other, use ```-lA -lB -lA``` (although such cases are quite rare).

### External libraries 
There are already a long list of libraries provided on the Mahuika platform. Most of them are provided in modules. You can search them using
```
module avail
```
and look in the module description using:
```
module help <module-name>
```
Sometimes modules provide multiple libraries, e.g. *cray-libsci*.

Most libraries are provided using the EasyBuild software management system, that NeSI/NIWA use to provide modules. Easybuild automatically defines environment variables ```$EBROOT<library name in upper case>``` when a module is loaded, which help pointing the compiler and linker to include files and libraries as in the example above. Thus, you can keep your makefile library version independent, by defining e.g. ```-L$EBROOT<library name in upper case>/lib```. Therewith you can use another version by only swapping modules. If you are unsure which ```$EBROOT<...>``` variables are available, use
```
module show <module-name>
```
to find out.

Note that specifying search paths with ```-I``` and ```-L``` is not strictly necessary in case of the GNU and Intel compilers, which will use the contents of ```CPATH```, ```LIRARY_PATH```, and ```LD_LIBRARY_PATH``` provided by the NeSI/NIWA module. This will not work with the Cray compiler.

**Important note:** Make sure that you load the correct variant of a library, depending on your choice of compiler. Switching compiler environment will *not* switch NeSI/NIWA modules automatically. Furthermore, loading a NeSI/NIWA module may switch programming environment if it was built with a different compiler. In general, the used library should be build with the same compiler. 

**Note:** the mentioned MPI compilers are practically compiler wrappers adding the location to the MPI library. This can be observed calling e.g. ```mpif90 -showme```

### Common linker problems

Linking can easily go wrong. Most often, you will see linker errors about "missing symbols" when the linker could not find a function used in your program or in one of the libraries that you linked against. To resolve this problem, have a closer look at the function names that the linker reported:

* Are you missing some object code files (these are compiled source files and have suffix ```.o```) that should appear on the linker line? This can happen if the build system was not configured correctly or has a bug. Try running the linking step manually with all source files and debug the build system (which can be a lengthy and cumbersome process, unfortunately).
* Do the missing functions have names that contain "mp" or "omp"? This could mean that some of your source files or external libraries were built with OpenMP support, which requires you to set an OpenMP flag (```-fopenmp``` for GNU compilers, ```-openmp``` for Intel) in your linker command. For the Cray compilers, OpenMP is enabled by default and can be controlled using ```-h[no]omp```. 
* Do you see a very long list of complex-looking function names, and does your source code or external library dependency include C++ code? You may need to explicitly link against the C++ standard library (```-lstdc++``` for GNU and Cray compilers, ```-cxxlib``` for Intel compilers); this is a particularly common problem for statically linked code.
* Do the function names end with an underscore ("_")? You might be missing some Fortran code, either from your own sources or from a library that was written in Fortran, or parts of your Fortran code were built with flags such as ```-assume nounderscore``` (Intel) or ```-fno-underscoring``` (GNU), while others were  using different flags (note that the Cray compiler always uses underscores).
* Do the function names end with double underscores ("__")? Fortran compilers offer an option to add double underscores to Fortran subroutine names for compatibility reasons (```-h [no]second_underscore```, ```-assume [no]2underscores```, ```-f[no-]second-underscore```) which you may have to add or remove.
* Compiler  not necessarily enable preprocessing, which could result in ```#ifndef VAR; Warning: Illegal preprocessor directive```. For example, using preprocessor directives in ```.f``` files with gfortran requires the ```-cpp``` option. 

Note that the linker requires that function names match exactly, so any variation in function name in your code will lead to a "missing symbols" error (with the exception of character case in Fortran source code).

## Cray Programming Environment
The Cray Programming Environment includes the Cray compiler, various libraries and tools. These work nicely together and provide certain user-friendly features by using compiler wrappers. This works very similar as the Cray XC environment, provided on Maui, and is described in detail at page [building Code on Maui](https://github.com/nesi/hpc_training/blob/building-code-on-maui-content/_lessons/maui-and-mahuika/12-building-code-on-maui.md). 

**Note**, in contrast to Maui, only the Cray compiler is provided in this environment. This cray compiler on Mahuika provides only dynamic linking support.

<!-- 
--------------
- static linking (with gnu or intel?) (OpenMPI has no static libmpi...)

- how to compile for GPUs (modules, compilers etc.)
----------------
 -->













