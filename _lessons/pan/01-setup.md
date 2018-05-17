---
layout: post
title: Setting up
permalink: /lessons/pan/setting-up/
chapter: pan
---

To be able to work on NeSI clusters, you will need to get an account first. Depending on the workshop set up that you will be attending, the organisers may be able to get you to use generic training accounts. **Warning:** these training accounts, and any data associated with them, will be deleted immediately after the workshop. If you wish to continue working on your research using NeSI, you will need to apply for an account.

Please see: [NeSI website](https://www.nesi.org.nz/apply) for more details.

Once you have your account (and know your username and password), you will be able to log in. Open the terminal on your machine (for more info see below) and type in:

```
ssh your_username@XXX.nesi.org.nz
```

See detailed [login instructions using MobaXTerm on Windows](https://wiki.auckland.ac.nz/display/CER/FromZeroToHero). If you are using Linux, Mac OS or maybe a Unix system, you will be able to log in using a standard terminal.

On NeSI supercomputers, your username and some details related to the login steps will vary - [see for details](https://wiki.auckland.ac.nz/display/CER/Access+and+data+transfer).

When you execute the line above, you will be asked to input your password and then you should be logged in on the **login node**.

```
Last login: Thu Mar  9 15:38:43 2017 from it346501.uoa.auckland.ac.nz

      *******************************************************************
      **         Welcome to XXX, the NeSI Supercomputer                **
      **                                                               **
      *******************************************************************


[ ~]$
```

### Working in Unix/Linux environment

In order to use HPC resources (not only those provided by NeSI), you will almost always have to interact with it using command line. If you are not familiar with it, have a look at these [Software Carpentry materials](http://swcarpentry.github.io/shell-novice/) which should help you get up to speed.

### Getting the training material

During our workshop we will use some R scripts, some SLURM scripts and some sample data.

Let's start first with downloading the workshop materials. You can download all materials from the [GitHub repository as a zip file](https://github.com/murraycadzow/hpc_training/archive/master.zip). Save this zip file on your laptop/desktop in a preferred location.

Once you finished downloading, unzip the file. You will see three subfolders:
* `data`
* `lessons`
* `code`

All SLURM scripts are found in code/SLURM/ and all R scripts are found in code/R/


Now we will transfer some of the files from these subfolders onto the cluster. We will show you two ways of doing it:

**1)** If you are working on Windows using MobaXterm, [you can use the drag'n'drop user interface which MobaXterm offers](https://wiki.auckland.ac.nz/display/CER/FromZeroToHero)
**2)** You can use the command line built-in programme `scp` (*secure copy*). It should work on standard Mac and Linux operating systems (in the built-in terminal). It will also work in the MobaXTerm command line on Windows.

To use `scp` to copy the file from your local machine type in the terminal on your local machine (so not on the cluster!):

```
scp <path_to_files> <your_username>@XXX.nesi.org.nz:<destination_path>

```

To specify the ssh key, use:

```
scp -i ~/.ssh/XXX_rsa_key <path_to_files> <your_username>@XXX.nesi.org.nz:<destination_path>
```

You need to replace the <path_to_files> and <destination_path> with the correct path to your file and then to the destination on the cluster. So for example:

```
scp data/inflammation-01.csv  apaw363@XXX.nesi.org.nz:/home/apaw363/
```

If you set up the SSH keys correctly, then the file transfer should go through.


To transfer files to your local machine:

```
scp -i ~/.ssh/XXX_rsa_key <your_username>@XXX.nesi.org.nz:<path_to_file_on_nesi> <local_destination_path>
```

A directory can also be transferred by using the -r flag for recursive

```
scp -r -i ~/.ssh/XXX_rsa_key <path_to_directory> <your_username>@XXX.nesi.org.nz:<destination_path>
```

For example:

```
scp -r -i ~/.ssh/XXX_rsa_key /home/username_on_local_machine/Desktop/python-novice-inflammation-data/ your_username@XXX.nesi.org.nz:/home/your_username

```

### Keeping your data in sync with the cluster

(This section is based on the ["High Performance Computing at NYU" materials](https://wikis.nyu.edu/display/NYUHPC/How+to+copy+files+to+and+from+the+HPC+clusters) )


`rsync` is a piece of software that allows for not only copying files and directories like `scp` but also preserves the permissions and file modification timestamps.

```
rsync -e ssh -av source destination
```

Options:

* a "Archive" mode - permissions and timestamps of the source are replicated at the destination.
* v "Verbose".
* n  "dry run" - don't actually do anything, just indicate what would be done.
* C "follow CVS ignore conventions" - more on this below.

Example:

```
rsync -e ssh -av your_username@login.uoa.nesi.org.nz:/home/your_username/folder Downloads/
```

### Transferring large amount of data

NeSI can provide support for transferring large amount of data (1 TB and more) via [Globus](https://www.globus.org/). If your organisation is a member of the Tuakiri Identification system, then the setup for this is fairly straightforward.
