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

## Environment Modules

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
* Switch out a loaded module for a different version:
  ```
  module swap Python/2.7.14-gimkl-2017a Python/3.6.3-gimkl-2017a
  ```
For more details run `module help`.

### Lmod shortcuts

On Mahuika we are using an enhanced version of modules called Lmod (it was
there on Pan, too).

Lmod extends the basic environment modules by adding simple shortcuts and a
more powerful search capability. The `ml` shortcut can be used in place of
`module`. With `ml` you can:

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

Further information about Lmod can be found in the online
[User Guide for Lmod](https://lmod.readthedocs.io/en/latest/010_user.html).


### Modules available on Mahuika

Most software installed on Pan and still in recent use has also been installed on
Mahuika, though not many old versions of each one.  Let us know if something you
need is missing.

There is also some software provided by Cray.  If necessary you can tell which is
which via `module avail`.

### Default Modules on Mahuika

Currently there are a few modules loaded by default when you log in, and one of these
is Slurm, which is essential for submitting jobs.  So, if you use `module purge` also
follow it up with `module load slurm`.

There is also currently a warning on login "The system default contains no modules"
which can be ignored.

### Planned changes

We will soon tidy up the modules so that Slurm can not be so easily unloaded.  It is
likely that _slurm_ will be made into a "Sticky" module which will not be unloaded by
a simple `module purge`, and it will be joined by a sticky _nesi_ module which will
make only our software available, with `module load cray` being necessary to access the
Cray environment modules.

## Create your own modules
You can create personalised module environments, which can load modules and set
up environment variables. For example, you could define a module
`~/modulefiles/MyEnv` as the following:

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

_For more information, [click
here](https://support.nesi.org.nz/hc/en-gb/articles/360000170355)._

### Software tiers

In order to more effectively focus our support efforts on our most widely used
scientific software packages, we have begun introducing a tiered software
support model.

* **Tier 1** software packages are those we specifically adopt for premium
  support. When supporting a package to this standard, we will:
  * Install it centrally and make it available to appropriately licensed users.
  * Keep it up to date with latest stable releases.
  * Test it frequently to ensure that it continues to work as expected.
  * Study, optimise and publish its performance and scaling behaviour.
  * Publish detailed information on how to get the best performance out of the
    application on our systems.
  * Cultivate expertise in use of the package within our support team.
* **Tier 2** software packages are those packages that have some demand, but
  we have not decided to adopt as Tier 1. When supporting a package to this
  standard, we will:
  * Install it centrally and make it available to appropriately licensed users.
  * Update it to stable releases on request and subject to available capacity.
  * Occasionally run any tests we have from time to time to verify that it
    continues to work as expected.
  * Publish basic information on how to run the application on our systems.
* **Tier 3** software packages are only used by a handful of researchers, often
  within a single project team. Research teams should manage their own Tier 3
  software, though we may be able to provide some assistance with compilation or
  installation. Tier 3 software will not be listed in our software catalogue and
  we will not ordinarily provide software documentation for it.

Not all installed software is currently categorised within a software tier. We
will continue to update our software catalogue over time.

### Requesting software installs

To request that we install a scientific application (either a new application,
or a new version of an already installed application), please [file a ticket](https://support.nesi.org.nz/hc/en-gb/requests/new) with the subject
*"New software request"*. In your message, please provide the following information:

* Why would you like us to install this software package?
* What is the name and version number of the software you would like installed?
* If you wish to use a copy from a version control repository, what tag or
  release do you need?
* How is the package installed? For example, compiled from source, pre-compiled
  binary, or installed as a Python, Perl, R, etc. library?
* What dependencies, if any, does the package require? Please be aware that the
  exact dependency list may depend on the particular use cases you have in mind
  (like the ability to read and write a specific file format).
* Have you (or another member of your project team) tried to install it yourself
  on a NeSI system? If so, were you successful?
* If you or your institution doesn't own the copyright in the software, under
  what license are you permitted to use it? Does that license allow you to
  install and run it on a NeSI system? (Hint: Most free, open-source software
  licenses will allow you to do this.)
* Who else do you know of who wants to use that software on a NeSI system?
  Please provide their names, institutional affiliations, and NeSI project
  codes.
* What tests do you have that will allow us to verify that the software is
  performing correctly and at an acceptable speed?

Our team will review your request and will make a decision as to whether we will
install the application and make it generally available.
