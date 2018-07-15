---
layout: post
title: Installing packages locally (Python and R)
permalink: /lessons/maui-and-mahuika/installing-packages-locally
chapter: maui-and-mahuika
---

## Objectives

You will learn:

* how to install a Python packages in your home directory
* how to install a R package in your home directory
* how to download, unpack, configure, build and install a C++ package


## How to install Python packages with pip

Make sure to load one of the Python versions installed on Mahuika, e.g.
```
module load Python/2.7.14-gimkl-2017a
```
as this will provide you with many Python modules. You can check if a module is 
already installed by typing, for instance,
```
python -c "import pnumpy"
```
where `pnumpy` is the name of the Python module. Beware that Python modules and 
package names may be different.

If you see an error such as `ImportError: No module named pnumpy` then the Python module is
not available at which point you may want to proceed and install the package locally in 
your home directory. 

Be sure you have everything you need to build the package - you may need to load
some extra modules as dependencies if the software you are installing requires
them. Note that when you loaded the Python module earlier, it loaded many such
dependencies already (for example MPI and BLAS/LAPACK libraries) - run `ml` to
view all loaded modules.

To install `pnumpy` locally, type
```
pip install pnumpy --user
```
The package will then be downloaded, built, including dependencies and installed under `$HOME/.local`. 


## How to install an R package locally

Make sure to have R loaded, e.g.,
```
module load R/3.5.0-gimkl-2017a
```
Then in R, type
```
> install.packages('abc')
```
to install package "abc". Answer the questions about the FTP mirror and confirm that you want to install locally. 
You can check that the package built correctly in R with
```
> library('abc')
```

## How to build generic packages in your home directory

Building Fortran, C and C++ packages typically involves a four step process.

 1. Get the package and unpack 

    The most common format for distributing a package is as a "tarball". Get the tarball,
    ```
    wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-cxx-4.2.tar.gz
    ```
    and unpack it
    ```
    tar xf netcdf-cxx4-4.3.0.tar.gz
    ```
    This will uncompress the file into a directory called `netcdf-cxx4-4.3.0`. Enter the
    just created directory:
    ```
    cd netcdf-cxx4-4.3.0
    ```

 2. Load a toolchain or compilers (along with any other dependencies that are required)
    to build the package with, for example the `gimkl-2017a` toolchain gives you the
    GNU compilers (5.4.0), Intel MPI and Intel MKL:
    ```
    module load gimkl/2017a
    ```

 3. Configure the package

    Most packages need to be configured before being built. Read the accompagnying README or INSTALL file as it will detail
    this step. This package uses autotools,

    ```
    # to list the configuration options
    ./configure --help
    ./configure --prefix=$HOME/software/netcdf-cxx4-4.3.0
    ```


 4. Build the package and install

    Then do
    ```
    make && make install
    ```
    to build and install.
