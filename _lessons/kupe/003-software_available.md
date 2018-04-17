---
layout: post
title: Available software
permalink: /lessons/kupe-software-available/
---

You will learn how to access the software stack with the module environment.

### Architectures

Kupe consists of nodes with two different architectures and operating systems:

* XC50 compute nodes that run a slim version of SLES (SUSE Linux Enterprise Server)
* Virtualised CS500 nodes that run a full version of CentOS

NeSI and NIWA will offer separate software stacks, due to different installation and maintenance policies. The NIWA software stack will mostly be used by NIWA's forecasting operations, while the NeSI software stack is for general use.

The software stack loosely falls into different categories, such as tools, general scientific libraries, or libraries that will be used with large codes (which typically have Fortran bindings and are therefore compiler-dependent).

Due to the different operating systems and runtime resource constraints (available cores, memory, IO bandwidth; see previous lesson), software will typically be built for either the XC50 or CS500 platform. Each platform supports the Cray, Intel and GNU compilers (Fortran, C and C++). Some packages will be built using a single (default) compiler while some will be built using multiple compilers, depending on context. For instance, tools and C libraries will likely be built with the GNU compiler whereas Fortran libraries might be built using multiple compilers.

| Type                                      | Default Compiler | XC50 (SLES)        | CS500 (CentOS)     |
|-------------------------------------------|------------------|:------------------:|:------------------:|
| Tools (e.g., NCL, gnuplot)                | GNU              |                    | :heavy_check_mark: |
| General scientific libraries (e.g., GDAL) | GNU              |                    | :heavy_check_mark: |
| Libraries for large codes (e.g., XIOS)    | Cray, Intel, GNU | :heavy_check_mark: |                    |

### Modules

Most software packages installed on FitzRoy will be available on Kupe (HPC3) using [Lmod](https://lmod.readthedocs.io/en/latest/) modules. Using Lmod is largely the same as using the traditional environment modules but Lmod has a few additional tricks.

Although the software stacks are still being built, a preliminary version of the NIWA software stack can be loaded using
```
source /opt/niwa/share_prelim/niwa_modules.sh
```
A list of available software can be obtained with the
```
module avail
```
command. This will bring up software provided by Cray, and additional modules provided by NeSI or NIWA. You can also find out which variants of a particular module exist using
```
module avail <module name>
```
Here ```<module name>``` is the module name without the version number (not a regular expression). For instance,
    ```
    module avail cray-netcdf
    ```

To get a list of modules that you are currently using, type
```
module list
```
To get information about a particular module, use
```
module help <module name>
module show <module name>
```

To find all modules that, e.g., have "python" in their name, use
```
module spider python
```
(Will be supported with lmod).

### Available software on Kupe

Software on Kupe is made available for XC50 nodes and CS500 nodes separately, as different operating systems are used in the two cases (SLES on the XC50 nodes, CentOS on the CS500 nodes). Running
```
module avail
```
will only present you with software that is available on the same system.

Software is generally installed and maintained by the following providers:

* Cray: Compilers, some scientific libraries, and developer tools
* NeSI: General scientific software
* NIWA: Scientific software for weather and climate applications

**Note that only the Cray software stack and a preliminary version of the NIWA software stacks are currently available and will be loaded by default! The full NeSI and NIWA software stacks will be made available soon.**

#### XC50

Scientific software and tools that are currently available on the XC50 include:

| Module Name                               | Version(s)            | Built with compiler(s) | Notes                          |
|-------------------------------------------|-----------------------|:----------------------:|:------------------------------:|
| Anaconda2                                 | 4.2.0                 | ---                    |                                |
| CDO                                       | 1.9.0                 | GNU                    |                                |
| Charm++                                   | 6.8.0                 | Intel, GNU             |                                |
| cray-fftw                                 | 3.3.6.2               | Intel, Cray, GNU       | Provided by Cray               |
| cray-hdf5                                 | 1.10.1.1              | Intel, Cray, GNU       | Provided by Cray               |
| cray-hdf5-parallel                        | 1.10.1.1              | Intel, Cray, GNU       | Provided by Cray               |
| cray-libsci                               | 17.09.1               | Intel, Cray, GNU       | Provided by Cray               |
| cray-python                               | 17.09.1               | ---                    | Provided by Cray               |
| cray-netcdf                               | 4.4.1.1.6             | Intel, Cray, GNU       | Provided by Cray               |
| cray-netcdf-hdf5parallel                  | 4.4.1.1.6             | Intel, Cray, GNU       | Provided by Cray               |
| cray-petsc                                | 3.7.6.0               | Intel, Cray, GNU       | Provided by Cray               |
| cray-petsc-complex                        | 3.7.6.0               | Intel, Cray, GNU       | Provided by Cray               |
| cray-R                                    | 3.3.3                 | ---                    | Provided by Cray               |
| cray-trilinos                             | 12.10.1.1             | Intel, Cray, GNU       | Provided by Cray               |
| Cylc                                      | 7.5.0                 | ---                    |                                |
| ESMF                                      | 7.0.1                 | Intel, GNU             |                                |
| FCM                                       | 2017.10.0             | ---                    |                                |
| GDAL                                      | 2.2.1                 | GNU                    |                                |
| GEOS                                      | 3.6.2                 | GNU                    |                                |
| GRADS                                     | 2.2.0                 | GNU                    |                                |
| grib_api                                  | 1.23.1                | Intel, Cray            |                                |
| GSL                                       | 2.4                   | GNU                    |                                |
| HDF                                       | 4.2.13                | GNU                    |                                |
| HDF-EOS                                   | 2.19v1.00             | GNU                    |                                |
| HDF-EOS5                                  | 5.1.15                | GNU                    |                                |
| ImageMagick                               | 7.0.7-9               | GNU                    |                                |
| mjpegtools                                | 2.1.0                 | GNU                    |                                |
| mpi4py                                    | 2.0.0                 | GNU                    |                                |
| NAMD                                      | 2.12                  | Intel, GNU             |                                |
| NCL                                       | 6.4.0                 | GNU                    |                                |
| NCO                                       | 4.6.8                 | GNU                    |                                |
| NCVIEW                                    | 2.1.8                 | GNU                    |                                |
| pfunit                                    | 3.2.8                 | Intel                  |                                |
| PROJ                                      | 4.9.3                 | GNU                    |                                |
| PSyclone                                  | 1.5.0                 | GNU                    |                                |
| RegCM                                     | 4.4.5.5               | Intel, Cray, GNU       |                                |
| Rose                                      | 2017.10.0             | ---                    |                                |
| SCons                                     | 3.0.0                 | ---                    |                                |
| SPECFEM3D                                 | 20171123              | Intel, GNU             |                                |
| splat                                     | 1.0.3                 | ---                    |                                |
| UDUNITS                                   | 1.12.11, 2.2.25       | GNU                    |                                |
| um2netcdf                                 | 3.2.0                 | GNU                    |                                |
| XCONV                                     | 1.93                  | ---                    |                                |
| XIOS-NC4PAR                               | r1242                 | Intel                  | Supports HDF5-parallel netCDF4 |

#### CS500

Scientific software and tools that are currently available on the CS500 include:

| Module Name                               | Version(s)            | Built with compiler(s) | Notes                          |
|-------------------------------------------|-----------------------|:----------------------:|:------------------------------:|
| Anaconda2                                 | 4.2.0                 | ---                    |                                |
| CDO                                       | 1.9.0                 | GNU                    |                                |
| Cylc                                      | 7.5.0                 | ---                    |                                |
| FCM                                       | 2017.10.0             | ---                    |                                |
| GDAL                                      | 2.2.1                 | GNU                    |                                |
| GEOS                                      | 3.6.2                 | GNU                    |                                |
| GRADS                                     | 2.2.0                 | GNU                    |                                |
| GSL                                       | 2.4                   | GNU                    |                                |
| HDF                                       | 4.2.13                | GNU                    |                                |
| HDF-EOS                                   | 2.19v1.00             | GNU                    |                                |
| HDF-EOS5                                  | 5.1.15                | GNU                    |                                |
| IDL                                       | 8.5                   | ---                    |                                |
| ImageMagick                               | 7.0.7-11              | GNU                    |                                |
| IRIS                                      | 1.3.0                 | ---                    |                                |
| mjpegtools                                | 2.1.0                 | GNU                    |                                |
| NCL                                       | 6.4.0                 | GNU                    |                                |
| NCO                                       | 4.6.8                 | GNU                    |                                |
| NCVIEW                                    | 2.1.8                 | GNU                    |                                |
| netCDF                                    | 4.5.0                 | GNU                    |                                |
| netCDF-Fortran                            | 4.5.0                 | GNU                    |                                |
| Perl                                      | 5.24.1                | GNU                    |                                |
| PROJ                                      | 4.9.3                 | GNU                    |                                |
| R                                         | 3.3.3                 | GNU                    |                                |
| Rose                                      | 2017.10.0             | ---                    |                                |
| SCons                                     | 3.0.0                 | ---                    |                                |
| splat                                     | 1.0.3                 | ---                    |                                |
| UDUNITS                                   | 1.12.11, 2.2.25       | GNU                    |                                |
| um2netcdf                                 | 3.2.0                 | GNU                    |                                |

**Never purge your environment - many modules are required in one version or another!**

### Requesting software installation
If you need a software package and it is not installed on Kupe, please email support@nesi.org.nz. If the software can be compiled on Kupe, runs there and there are no licensing restrictions, we will make every effort to install the software within days. Occasionally, we may need more time to investigate the licensing set up (for example, if the licensing server is provided through your organisation.)
