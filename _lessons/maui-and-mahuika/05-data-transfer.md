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
**NOTE**
> Both scp and sftp use `ssh` (secure shell), so it's important that before you proceed, you verify that you can successfully ssh into the lander node and directly into mahuika/maui with the command `ssh mahuika` following the instructions at [jumping across the lander node](connecting#ssh_jump_node)

--- 


## scp ##
The syntax for the scp command is:

```console
 scp [options] source_user@source_host:source_path dest_user@dest_host:dest_path
```

* The source file is specified by the first argument, ```source_user@source_host:source_path```, where:

|argument| description|
|----------|-----------|
  |source_user| source username |
  |source_host| url or hostname of host on which the source file resides |
  | source_path| /path/to/filename of source file |

* The destination file is specified by the second argument, ```dest_user@dest_host:dest_path```, where:

|argument| description|
|----------|-----------|
  |dest_user|destination username |
  |dest_host | url or hostname of host to which the source file will be copied |
  |dest_path| /path/to/filename of destination file|

--- 

**NOTE**
>    * The hostname of the local host can be omitted
>    * The directory of the file on the local host can be omitted if it is your current working directory

--- 

### copying files to the cluster ###

Copy a file from the current directory on your local host to your home directory on the cluster with either:

|```  scp filename mahuika:/home/username/```|copy file to home dir|
|```  scp filename mahuika:~/```|(same as previous)| 
|```  scp filename mahuika:/path/to/storage/location/```|copy file to another remote path
|```  scp filename mahuika:/path/to/storage/new_filename```|copy file to renamed remote file|
|```  scp filename mahuika:/nesi/project/nesi123456```|copy file to project folder|
|```  scp -r foldername mahuika:/path/to/storage/```|copy _folder_ to path|

Note: the `-r` option makes `scp` a _recursive_ copy.  See ```man scp``` for more options.

### copying files from the cluster ###

Examples:

--- 
> **Note:**
> *  location `.` stands for current local directory
> * `man scp` for more options

--- 


|```  scp mahuika:/home/username/filename  .```| copy file from remote home directory to current local directory|
|```  scp mahuika:~/filename .```|(same as previous)|
|```  scp mahuika:/path/to/storage/filename  /another/path/on/local/```|copy file from remote path to another local path|
|```  scp mahuika:/nesi/project/nesi123456/filename .```|copy path from remote project folder to current local directory|
|```  scp mahuika:/nesi/project/nesi123456/{a,b,c} .```| copy multiple remote files to here|
|```  scp -r mahuika:/nesi/project/nesi123456 .```| copy entire project folder to here|

(No spaces between the commas and filenames!)

### tar ###

There is overhead with each file transfer. If you are transferring a lot of small files, consider using `tar` to archive and compress the set of files and transfer just one file, the archive.

To transfer a directory tree from either end: navigate to that directory and at the shell

| command | explanation | where issued |
| --- | --- | --- |
| ```tar cvfz archive.tar.gz ./ ``` | create and compress archive | on source |
| ``` scp archive.tar.gz mahuika:path``` | copy to mahuika | on local |
| ``` scp mahuika:path/archive.tar.gz .``` | copy from mahuika | on local |
| ```see archive.tar.gz``` | see contents of archive | on source or target |
| ```tar xvfz archive.tar.gz``` | extract archive after scp | on target |


and everything will be uncompressed and unpacked to the same directory structure as it was before.

See ```man tar``` for options on excluding files from the transfer, and other options.
the ```c``` option means "create", the  "x" option means "extract".

## sftp ##
For an interactive file-transfer session, ```sftp``` is a convenient tool.
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

