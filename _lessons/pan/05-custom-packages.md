---
layout: post
title: Working with custom packages
permalink: /lessons/pan/custom-packages/
chapter: pan
---


### Working with R packages
Detailed NeSI [documentation on working with R packages](https://support.nesi.org.nz/hc/en-gb/articles/209338087-R#dealing-with-packages)

Tom Kelly (The University of Otago PhD graduate) [developed a number of scripts and examples](https://github.com/TomKellyGenetics/install.nesi) on how to install R packages on NeSI.

### Working with Python packages
Detailed NeSI [documentation on working with Python packages](https://support.nesi.org.nz/hc/en-gb/articles/207782537-Python#third-party-modules)


### Example of installing a custom R package

First, let's get onto a build node

```
[apaw363@login-01 ~]$ ssh build-wm
[apaw363@build-wm ~]$
```

Now, let's see which R versions we have available:

```
module spider R

-------------------------------------------------------------------------------------------------------------------------------------------------------------
 R:
-------------------------------------------------------------------------------------------------------------------------------------------------------------
   Description:
     R is a free software environment for statistical computing and graphics.

    Versions:
       R/3.0.3-goolf-1.5.14
       R/3.1.1-goolf-1.5.14
       R/3.1.1-iomkl-6.5.4
       R/3.1.2-goolf-1.5.14
       R/3.2.1-intel-2015a
       R/3.3.0-intel-2015a
       R/3.4.0-gimkl-2017a
       R/3.4.2-gimkl-2017a

    Other possible modules matches:
       ANTLR  ARCSI  Advisor  BioConductor  Bismark  BreakDancer  CNVnator  DendroPy  EMIRGE  Elmer  FastTree  FineMarine  FreeBayes  FreeSurfer  FreeXL  ...

-------------------------------------------------------------------------------------------------------------------------------------------------------------
 To find other possible module matches do:
     module -r spider '.*R.*'

-------------------------------------------------------------------------------------------------------------------------------------------------------------
 For detailed information about a specific "R" module (including how to load the modules) use the module's full name.
 For example:

    $ module spider R/3.4.2-gimkl-2017a
-------------------------------------------------------------------------------------------------------------------------------------------------------------

```

Some modules are loaded by default. To check that:
```
$ module list

Currently Loaded Modules:
  1) GCCcore/5.4.0                   11) PCRE/8.40-gimkl-2017a        21) expat/2.2.0-gimkl-2017a          31) libspatialite/4.3.0a-gimkl-2017a-GEOS-3.5.1
  2) binutils/2.26-GCCcore-5.4.0     12) ncurses/6.0-gimkl-2017a      22) libjpeg-turbo/1.5.1-gimkl-2017a  32) netCDF/4.4.1-gimkl-2017a
  3) GCC/5.4.0-2.26                  13) libreadline/6.3-gimkl-2017a  23) Szip/2.1-gimkl-2017a             33) PostgreSQL/9.6.2-gimkl-2017a
  4) impi/2017.1.132-GCC-5.4.0-2.26  14) libpng/1.6.28-gimkl-2017a    24) HDF/4.2.13-gimkl-2017a           34) GDAL/2.2.2-gimkl-2017a-GEOS-3.5.1
  5) gimpi/2017a                     15) libxml2/2.9.4-gimkl-2017a    25) HDF5/1.8.18-gimkl-2017a          35) NLopt/2.4.2-gimkl-2017a
  6) imkl/2017.1.132-gimpi-2017a     16) Tcl/8.6.6-gimkl-2017a        26) KEALib/1.4.6-gimkl-2017a         36) OpenSSL/1.1.0e-gimkl-2017a
  7) gimkl/2017a                     17) SQLite/3.16.2-gimkl-2017a    27) LibTIFF/4.0.7-gimkl-2017a        37) R/3.4.2-gimkl-2017a
  8) zlib/1.2.11-gimkl-2017a         18) cURL/7.52.1-gimkl-2017a      28) PROJ/4.9.3-gimkl-2017a
  9) bzip2/1.0.6-gimkl-2017a         19) Java/1.8.0_144               29) libgeotiff/1.4.2-gimkl-2017a
 10) XZ/5.2.3-gimkl-2017a            20) GEOS/3.5.1-gimkl-2017a       30) FreeXL/1.0.2-gimkl-2017a

```



Let's start R and see if the packages that we need are available:

```
$ R
....

> library(arules)
Error in library(arules) : there is no package called ‘arules'

```
Looks like we have to install  this library.

```
> install.packages("arules")
Warning in install.packages("arules") :
  'lib = "/gpfs1m/apps/easybuild/RHEL6.3/westmere/software/R/3.4.2-gimkl-2017a/lib64/R/library"' is not writable
Would you like to use a personal library instead?  (y/n)
```

```
Would you like to create a personal library
~/R/x86_64-pc-linux-gnu-library/3.4
to install packages into?  (y/n)
```


```
--- Please select a CRAN mirror for use in this session ---
Secure CRAN mirrors

 1: 0-Cloud [https]                   2: Algeria [https]
 3: Australia (Canberra) [https]      4: Australia (Melbourne 1) [https]
 5: Australia (Melbourne 2) [https]   6: Australia (Perth) [https]
 7: Austria [https]                   8: Belgium (Ghent) [https]
 9: Brazil (PR) [https]              10: Brazil (RJ) [https]
11: Brazil (SP 1) [https]            12: Brazil (SP 2) [https]
13: Bulgaria [https]                 14: Chile 1 [https]
15: Chile 2 [https]                  16: China (Guangzhou) [https]
17: China (Lanzhou) [https]          18: Colombia (Cali) [https]
19: Czech Republic [https]           20: Denmark [https]
21: East Asia [https]                22: Ecuador (Cuenca) [https]
23: Estonia [https]                  24: France (Lyon 1) [https]
25: France (Lyon 2) [https]          26: France (Marseille) [https]
27: France (Montpellier) [https]     28: France (Paris 2) [https]
29: Germany (Göttingen) [https]      30: Germany (Münster) [https]
31: Greece [https]                   32: Iceland [https]
33: Indonesia (Jakarta) [https]      34: Ireland [https]
35: Italy (Padua) [https]            36: Japan (Tokyo) [https]
37: Malaysia [https]                 38: Mexico (Mexico City) [https]
39: Norway [https]                   40: Philippines [https]
41: Serbia [https]                   42: Spain (A Coruña) [https]
43: Spain (Madrid) [https]           44: Sweden [https]
45: Switzerland [https]              46: Turkey (Denizli) [https]
47: Turkey (Mersin) [https]          48: UK (Bristol) [https]
49: UK (Cambridge) [https]           50: UK (London 1) [https]
51: USA (CA 1) [https]               52: USA (IA) [https]
53: USA (KS) [https]                 54: USA (MI 1) [https]
55: USA (OR) [https]                 56: USA (TN) [https]
57: USA (TX 1) [https]               58: Vietnam [https]
59: (other mirrors)

Selection:

```

And then, there is a LOT of output information on your screen to finally arrive to:

```
** testing if installed package can be loaded
* DONE (arules)

The downloaded source packages are in
    ‘/tmp/RtmpR64gHN/downloaded_packages’
```

Indeed now, I can use the package:
```
> library(arules)
Loading required package: Matrix

Attaching package: ‘arules’

The following objects are masked from ‘package:base’:

    abbreviate, write
```

But let's see what is in our home directory:

```
[apaw363@login-01 ~]$ ls R/x86_64-pc-linux-gnu-library/3.4/
arules       cli     dbplyr   hms        psych   rematch  rmarkdown   rvest      whisker
callr       clipr   forcats  lubridate  readr   reprex   rprojroot   selectr    xml2
cellranger  crayon  haven    modelr     readxl  rlang    rstudioapi
```
