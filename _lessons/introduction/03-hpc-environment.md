---
layout: post
title: Working in HPC environment
permalink: /lessons/introduction/hpc-environment/
chapter: introduction
---

# The material below is just copied from Pan materials - needs work to adapt to new platforms

NeSI clusters are a shared resource and hence there are certain rules as to what is available to each user by default. For small-scale projects the default amount of resources should be sufficient. If you need more compute power or disk allocation for your data, please contact support@nesi.org.nz.

### Quota

On the NeSI supercomputers the basic quota rules are (in brief summary):

* Every file, directory or symbolic link takes up either 32 KB of disk space or its actual size (rounded up to the nearest 32K), whichever is bigger.

* Every file, directory or symbolic link counts for one "inode".

* Your home directory has a disk space allotment of XXX GB (though we can give more home directory space in exceptional circumstances).

* Each project directory starts off with a space allotment of XXX GB and an inode allotment of 1,000,000 inodes, unless more space is requested (and agreed to by us) at the time the project is created.

* An increase in disk quota or inode quota can be given either until a specific date (provided the project keeps going until that date), or until the end of the project. Especially in the latter case, we may have to reduce your disk quota if we face operational constraints.

[See more details about the quota on NeSI](XXX)

To check your allocated disk space and file count quotas use:

```
fs_my_quota_usage
```

### Login vs build vs compute nodes

A typical cluster consists of several "parts". To simplify things we will briefly describe the three types of nodes that are usually available.
 In order to efficiently use HPC resources for your research, you do not need to know a lot of detail about the HPC architecture but you need to have a basic understanding of what you can use each type of node for.

* **Login Node**

- Used to access the cluster
- There usually are several login nodes - depending on the size and architecture of the cluster
- You have your home and project directories on the login node
- You upload your data and the code to the login node
- You download the results from the login node
- You submit the jobs from the login node


IMPORTANT: **Login nodes should never be used to: build and test your code, store large data files, store data permanently/long-term**

What does that actually mean?

* When on login node you should only submit jobs (a.k.a. run code) using the job scheduler. If you want to work interactively (for example, running your code directly), you should do that from the build node (see below).
* You should not try to edit large (probably more than 1GB) files when on the login node using standard editors (like Vim or Nano). If you need to preview a file, use `less` command.
* You should not compress a large file with gzip.


* **Build or Development Node**

- Used for building (compiling) your code
- Used for test runs for your code
- [More details on building your code on the Pan cluster](https://wiki.auckland.ac.nz/display/CER/Developing+software)
- NeSI's Cray has nodes:
    -  XXX
    -  XXX

To connect from the login node to a build node:

```
ssh -YC  XXX
```

The -Y option makes X forwarding. This mean that any GUI applications running on the cluster can have windows output on your screen. It should be enabled by default if you are connecting to HPC from Linux. If you are on a Mac, you may need to install an X server (for example, [XQuartz](http://xquartz.macosforge.org/landing/))

* **Compute Node**

- This is where your jobs actually run.
- Usually you don't have to worry about working with the compute nodes as a user


### Your projects and allocation

There are several ways to check which projects you have access to. The simplest way is:

```
show_my_projects
```

You can do that using the `id` command. The output may be for example:

```
uid=6157(apaw363) gid=5000(nesi) groups=5000(nesi),6075(nesi00357) context=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
```

To check how much allocation you have used so far:

```
fs_my_quota_usage
```


### Available software

You can use a variety of software already installed on the cluster.


### User Environment
LMOD is very useful to manage environment variables for each application and it is very easy to use. It loads the needed environment by a certain application and its dependencies automatically. The command line is fully compatible with the previous 'Environment Modules', and it provides simple short-cuts and advanced features.

Syntax :```module [options] sub-command [args ...]```
#### Loading/Unloading sub-commands
* load | add : load module(s)
* swap | switch : swap a module for another
* del | unload: Remove module(s), do not complain if not found
* update: reload all currently loaded modules.

#### Listing / Searching sub-commands
* list: List loaded modules
* avail | av: List available modules
* avail | av string: List available modules that contain "string".
* spider: List all possible modules
* spider module" List all possible version of that module file
* spider string: List all module that contain the "string".

#### Short-cuts
* ml - means: module list
* ml foo bar - means: module load foo bar
* ml -foo -bar baz goo - means: module unload foo bar; module load baz goo;

More information at http://www.tacc.utexas.edu/tacc-projects/lmod
