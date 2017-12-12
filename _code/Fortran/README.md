---
layout: post
title: FORTRAN code examples
permalink: /code/Fortran/
chapter: code-samples
---

# How to compile Fortran code in this directory

General instructions for Cray programming environment.

 1. Load/swap the programming environment of your choice, e..g. ```module swap PrgEnv-cray PrgEnv-intel```

 2. Invoke the ```ftn``` compiler wrapper

 3. Add add include directories (```-I ...```), library directories (```-L...```) and libraries (```-l...```) as required.

## SimpleMpi

This example shows how to compile an MPI program, which prints "Hello world from processor X".

```
ftn -o simpleMpiF90 simpleMpi.f90
```


## simple_xy_wr

This example shows how to compile a program that links to the Cray netCDF library.

```
module load cray-netcdf
ftn -o simple_xy_wr simple_xy_wr.f90
```

## simple_xy_par_wr

This example shows how to compile a program that links to the Cray parallel netCDF library.

```
module load cray-netcdf
ftn -o simple_xy_par_wr simple_xy_par_wr.f90
```
