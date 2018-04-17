---
layout: post
title: Installing packages locally (Python and R)
permalink: /lessons/maui-and-mahuika/installing-packages-locally
chapter: maui-and-mahuika
---

## Objectives

You will learn:

* how to install Python packages in your home directory
* how to install R packages in your home directory
* some tips for building generic packages in your home directory

To make things concrete we'll assume below that the software is called ```foo```, the 
version you want to install is ```2.1.0``` and that the installation directory is 
```$HOME/software/foo-2.1.0```.


### How to install Python packages with pip

At the UNIX command line prompt,
```
pip install 'foo==2.1.0' --user
```
The package will be installed under ```$HOME/.local```.


### How to install an R package locally

In R, type
```
install.packages('foo', lib='$HOME/sofware/foo-2.1.0')
```
You can then access the installed package within R using
```
library('foo', lib.loc='$HOME/software/foo-2.1.0')
```

### How to build generic packages in your home directory

Most packages involve a three step process. 

 1. Get the package and unpack 

 The most common format for distributing a package is as a "tarball", ```foo-2.1.0.tar.gz```,
typically downloaded from the web. Your first step will likely be 
 ```
 wget https://wonderful.software.com/foo-2.1.0.tar.gz
 ```
 followed by
 ```
 tar xf foo-2.1.0.tar.gz
 ```
 which will uncompress the file into a directory, perhaps called ```foo-2.1.0```. Enter the 
 just created directory:
 ```
 cd foo-2.1.0
 ```

 2. Configure the package

 Most packages need to be configured before being built. Read the accompagnying README or INSTALL file as it will detail 
 the build process. The most common way to configure is either

 ```
 ./configure --prefix=$HOME/software/foo-2.1.0 [other_options]
 ```
or
 ```
 cmake -D CMAKE_PREFIX_INSTALL=$HOME/software/foo-2.1.0
 ```
 In the above cases, the installation directory was specified. Often, you will need to provide additional help to configure sucessfully, e.g. give paths to externally dependent libraries and headers. You might also have to provide the compiler and potentially other settings.


 3. Build the package and install

Then do 
```
make
make install
```
to build and install foo-2.1.0.
