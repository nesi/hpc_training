---
layout: post
title: Finding software (modules)
permalink: /lessons/maui-and-mahuika/software-modules
chapter: maui-and-mahuika
---

## Objectives

You will learn:

* how NeSI supports software (software tiers)
* how to search for and load installed software
* how to create a personalised module environment
* how to request help installing software


**Content is currently under development. Check back soon.**

## Environment modules

NeSI uses environment modules to manage installed software.

Using the `module` command you can:

* View loaded modules:
  ```
  module list
  ```
* List all available modules
  ```
  module avail
  ```
* Load a module:
  ```
  module load Python/2.7.14-gimkl-2017a
  ```
* Switch a loaded module for a different version:
  ```
  module switch Python/2.7.14-gimkl-2017a Python/3.6.3-gimkl-2017a
  ```

### Lmod on Mahuika

On Mahuika we are using an enhanced version of modules called Lmod (it was
there on Pan, too).

Lmod extends the basic environment modules by adding simple shortcuts and a
more powerful search capability. The `ml` shortcut can be used in place of
`module`. With Lmod you can:

* View loaded modules:
  ```
  ml
  ```
* List all available modules:
  ```
  ml spider
  ```
* Use "spider" to search for modules, e.g. "Python" modules:
  ```
  ml spider Python
  ```
* Load a module:
  ```
  ml Python/2.7.14-gimkl-2017a
  ```
* Prefix a module with "-" to unload it, e.g. switch from Python 2 to Python 3:
  ```
  ml -Python/2.7.14-gimkl-2017a Python/3.6.3-gimkl-2017a
  ```
* To get a fresh environment, we recommend to log off and log in again.
  Thus not only the loaded modules are restored to the default ones,
  but also the environment variables are reset to the default ones.

Further information available in the online
[User Guide for Lmod](https://lmod.readthedocs.io/en/latest/010_user.html).

## Create your own modules
You can create personalised modules environments, which can load modules and set up environment variables. Thus you could define module `~/modulefiles/MyEnv` as following:
```
#%module

conflict MyOtherEnv
module load CMake
module load netCDF/4.4.1-gimkl-2017a

setenv CFLAGS "-DNDEBUG"
prepend-path PATH ~/tools/bin
```

To make that directory available to the module environment you need to specify:
```
module use ~/modulefiles
```
which you can also define in your `~/.bashrc`.
To load that environment, you simply load your module:
```
module load MyEnv
```

## Software support

### Software tiers


### Requesting software installs
