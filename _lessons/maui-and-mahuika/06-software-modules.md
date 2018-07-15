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
  module switch Python/2.7.14-gimkl-2017a Python/3.6.4-gimkl-2017a
  ```

### Lmod on Mahuika

On Mahuika we are using an enhanced version of modules called Lmod (it was
there on Pan too).

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
  ml -Python/2.7.14-gimkl-2017a Python/3.6.4-gimkl-2017a
  ```
* Clear all loaded modules
  ```
  ml purge
  ```

Further information available in the online
[User Guide for Lmod](https://lmod.readthedocs.io/en/latest/010_user.html).

## Software support

### Software tiers


### Requesting software installs


