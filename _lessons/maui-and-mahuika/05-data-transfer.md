---
layout: post
title: Data transfer
permalink: /lessons/maui-and-mahuika/data-transfer
chapter: maui-and-mahuika
---

## Objectives

You will learn:

* how to transfer small amounts of data to and from the system
* how to transfer large amounts of data
* how to bypass the lander node when copying data


**Content is currently under development. Check back soon.**
# transfer tools #
The basic toolkit consists of scp and sftp.
1.  scp  --  secure copy
2.  sftp -- secure file transfer protocol

### Preliminaries ###

--- 
> Both scp and sftp use `ssh` (secure shell), so it's important that before you proceed, you can successfully ssh into the lander node and directly into mahuika/maui with the command
> ```console
  ssh mahuika
  ```
> following the instructions at [jumping across the lander node](connecting#ssh_jump_node)

--- 


## scp ##
The syntax for the scp command is:

```console
 scp [options] username1@source_host:directory1/filename1 username2@destination_host:directory2/filename2
```

* The location of the source file is specified by ```username1@source_host:directory1/filename1```, which includes the:

  - Name of the account on the host computer (username1)
  - Hostname of the computer on which the source file resides (source_host)
  - Name of the directory containing the source file (directory1)
  - Filename of the source file (filename1)

* The location to which the source file will be copied is specified by ```username2@destination_host:directory2/filename2```, which includes the:

  - Name of the account on the destination computer (username2)
  - Hostname of the computer to which the source file will be copied (destination_host)
  - Name of the directory to which the source file will be copied (directory2)
  - Filename of the copy (filename2)

`Note`
* The hostname of the local host can be omitted
* The directory of the file on the local host can be omitted if it is your current working directory

### putting files on the cluster###
`Put` a file from your current directory on your local host to your home directory on the cluster with either
```console
  scp filename mahuika:/home/username/
  scp filename mahuika:~/
```
In general, put a file somewhere on mahuika:
```console
  scp filename mahuika:/path/to/storage/location/
```
Put a file somewhere on mahuika and change its name:
```console
  scp filename mahuika:/path/to/storage/location/new_filename
```

Put a file in your project directory on the cluster:

```console
  scp filename mahuika:/nesi/project/nesi123456
```

#### putting a folder on the cluster ####
Put a folder from your current directory to your project directory on the cluster:

```console
  scp -r foldername mahuika:/nesi/project/nesi123456/subpath/
```

### getting files from the cluster ###

Get a file from your home directory on the cluster with either
```console
  scp mahuika:/home/username/filename  .
  scp mahuika:~/filename .
```
In general, get a file from somewhere on mahuika:
```console
  scp mahuika:/path/to/storage/location/filename  .
```

Get a file from your project directory on the cluster:

```console
  scp mahuika:/nesi/project/nesi123456/filename .
```

Get files `a`, `b`, and `c`  from your project directory on the cluster:
```console
  scp mahuika:/nesi/project/nesi123456/{a,b,c} .
```

### tar ###

There is overhead with each file transfer. If you are transferring a lot of small files, consider using `tar` to archive and compress the set of files and transfer just one file, the archive.


To transfer a directory tree from either end: navigate to that directory and at the shell:

```console
tar cvfz archive.tar.gz ./
```

A file `archive.tar.gz`  is created containing a compressed archive of the directory.

Put:
```console
scp archive.tar.gz mahuika:/path/
```
or get:
```console
scp mahuika:/path/archive.tar.gz  .
```

And on the target host, navigate to where the archive is and unpack it: 

```console
tar xvfz archive.tar.gz
```

and everything will be uncompressed and unpacked to the same directory structure as it was before.

See ```man tar``` for options on excluding files from the transfer, and other options.

## sftp ##
For an interactive file-transfer session, ```sftp``` is a convenient option:

From your local host,

```console
sftp mahuika
```

should open a prompt
```
sftp>
```

From here you can inspect the state of the remote while transferring, and issue the following:

 | command  |  explanation |
 | -------- | ------------- |
 | ```cd``` |  navigate on remote |
 | ```lcd``` |  navigate on local |
 | ```ls``` |  list files  |
 | ```mkdir``` |  create directories  |
 | ```rmdir``` |  remove directories |
 | ```put``` |  from local to remote |
 | ```get``` |  from remote to local |
 | ```help``` |  see all commands |
 |----------|-----------------|

--- 

**Speeding up**

You can use globbing to put/get a bunch of files all at once:

| command | explanation |
|----|----- |
| ```put foo*``` |  put all files in cwd starting with ```foo``` from local to remote |
| ```put *.c``` |  put all files in cwd ending with ```.c``` from local to remote |
| ```get foo*``` | get all files in cwd starting with ```foo```  from remote to local |
| ```get *.py``` | get all files in cwd ending with ```".py"```  from remote to local |
|----|----|

where
```cwd == "current working directory"```, at either end!


--- 
> **NOTE**
> * Use ```man sftp``` to see options on get and put.
>   - the -a option permits resuming a partial transfer
>   - the -r option permits transferring a directory
>   - the -p option permits transferring file permissions and timestamps
> * Use ``` ls -lt``` to see long listing of directory on remote host.

--- 

