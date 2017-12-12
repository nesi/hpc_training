---
layout: post
title: C code examples
permalink: /code/c-code/
chapter: code-samples
---

# How to compile C code in this directory

General instructions for Cray programming environment.

 1. Load/swap the programming environment of your choice, e..g. ```module swap PrgEnv-cray PrgEnv-intel```

 2. Invoke the ```CC``` compiler wrapper

 3. Add add include directories (```-I ...```), library directories (```-L...```) and libraries (```-l...```) as required.

## SimpleMpi

This example shows how to compile an MPI program, which prints "Hello world from processor X".

```
CC -o simpleMpiC simpleMpi.c
```


## gsl_statistics_example

This example shows how to compile a program that links to the GNU Scientific library (GSL). Unless the Cray C compiler is used, it should not be necessary to specify include and library search paths:

```
module load GSL
cc -o gsl_statistics_example gsl_statistics_example.c -lgsl
```
If you do need to specify the paths, you can use the ```EBROOTGSL``` environment variable provided by the EasyBuild module:
```
cc -I$EBROOTGSL/include -o gsl_statistics_example gsl_statistics_example.c -L$EBROOTGSL/lib -lgsl
```
Alternatively, to avoid loading the GSL module which will load the GNU module, you can
```
EBROOTGSL=/mnt/FS4MB/NESINIWA/n17755/easybuild/software/GSL/2.4-CrayGNU-2017.06
cc -I$EBROOTGSL/include -o gsl_statistics_example gsl_statistics_example.c -L$EBROOTGSL/lib -lgsl
```

Note: the path ```/mnt/FS4MB/NESINIWA/n17755/easybuild/software/GSL/2.4-CrayGNU-2017.06``` can be obtained by typing ```module show GSL```. Also the second method allows you to mix the GNU compilers with either Cray of Intel, which works for C but typically not for Fortran programs.

## grib_example

This example shows how to compile a program that links to the GRIB API library:
```
cc -I$EBROOTGRIB_API/include -o grib_example grib_example.c -L$EBROOTGRIB_API/lib -lgrib_api
```
