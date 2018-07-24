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
> Both scp and sftp use `ssh` (secure shell), so it's important that before you proceed, you verify that you can successfully ssh into the lander node and directly into mahuika/maui with the command `ssh mahuika` following the instructions at [jumping across the lander node](03-connecting.md#ssh_jump_node)

--- 


## scp ##
The syntax for the scp command is:

```console
 scp [options] source_user@source_host:source_path dest_user@dest_host:dest_path
```

* The source file is specified by the first argument, ```source_user@source_host:source_path```, where:

|argument| description|
|----------|-----------|
  |`source_user`| source username |
  |`source_host`| url or hostname of host on which the source file resides |
  |`source_path`| /path/to/filename of source file |

* The destination file is specified by the second argument, ```dest_user@dest_host:dest_path```, where:

|argument| description|
|----------|-----------|
  |`dest_user`|destination username |
  |`dest_host`| url or hostname of host to which the source file will be copied |
  |`dest_path`| /path/to/filename of destination file|

--- 

**NOTE**
>    * The hostname of the local host can be omitted
>    * The directory of the file on the local host can be omitted if it is your current working directory

--- 

### copying files to the cluster ###

Here the source is your workstation, the destination is `mahuika`.


<table>
<tr>
    <td><code>scp filename mahuika:/home/username/</code></td>
    <td> copy file to home dir </td>
</tr>
<tr>
    <td><code>scp filename mahuika:~/</code></td>
    <td> (same as previous) </td>
</tr> 
<tr>
    <td><code>scp filename mahuika:/path/to/storage/location/</code> </td>
    <td> copy file to another remote path </td>
</tr>
<tr>
    <td><code>scp filename mahuika:/path/to/storage/new_filename</code> </td>
    <td> copy file to renamed remote file</td>
</tr>
<tr>
    <td><code>scp filename mahuika:/nesi/project/nesi123456</code> </td>
    <td> copy file to project folder </td>
</tr>
<tr>
    <td><code>scp -r foldername mahuika:/path/to/storage/</code> </td>
    <td> copy _folder_ to path </td>
</tr>
</table>

Note: the `-r` option makes `scp` a _recursive_ copy.  See ```man scp``` for more options.

### copying files from the cluster ###

Here the source is `mahuika`, the destination is your workstation.

--- 
> **Note:**
> *  location `.` stands for current local directory
> * `man scp` for more options

--- 


<table>
<tr>
    <td>
        <code>scp mahuika:/home/username/filename  .</code>
    </td>
    <td> 
        copy file from remote home directory to current local directory
    </td>
</tr>
<tr>
    <td><code>scp mahuika:~/filename .</code></td>
    <td>(same as previous)</td>
</tr>
<tr>
    <td><code>scp mahuika:/path/to/storage/filename  /another/path/on/local/</code></td>
    <td>copy file from remote path to another local path</td>
</tr>
<tr>
    <td><code>scp mahuika:/nesi/project/nesi123456/filename .</code></td>
    <td>copy path from remote project folder to current local directory</td>
</tr>
<tr>
    <td><code>scp mahuika:/nesi/project/nesi123456/{a,b,c} .</code></td>
    <td> copy multiple remote files to here</td>
</tr>
<tr>
    <td><code>scp -r mahuika:/nesi/project/nesi123456 .</code></td>
    <td> copy entire project folder to here</td>
</tr>
</table>

(No spaces between the commas and filenames!)

### tar ###

There is overhead with each file transfer. If you are transferring a lot of small files, consider using `tar` to archive and compress the set of files and transfer just one file, the archive.

To transfer a directory tree from either end, navigate to that directory on the source and destination, and at the shell:

<table>
<tr>
    <th> command </th>
    <th> explanation </th>
    <th> where issued </th>
</tr>
<tr>
    <td> <code>tar cvfz archive.tar.gz ./ </code> </td>
    <td> create and compress archive </td>
    <td> on source </td>
</tr>
<tr>
    <td> <code> scp archive.tar.gz mahuika:path</code> </td>
    <td> copy to mahuika </td>
    <td> on local </td>
</tr>
<tr>
    <td> <code> scp mahuika:path/archive.tar.gz .</code> </td>
    <td> copy from mahuika </td>
    <td> on local </td>
</tr>
<tr>
    <td> <code>see archive.tar.gz</code> </td>
    <td> see contents of archive </td>
    <td> wherever archive exists</td>
</tr>
<tr>
    <td> <code>tar xvfz archive.tar.gz</code> </td> 
    <td> extract archive after scp </td>
    <td> on target </td>
</tr>
</table>


and everything will be copied over and finally uncompressed and 
unpacked to the same directory structure as it was before, with one file-copy.

See ```man tar``` for options on excluding files from the transfer, and other options.
the ```c``` option means "create", the  "x" option means "extract".

## sftp ##
For an interactive file-transfer session, `sftp` is a more full-featured tool than `scp`.
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


The two operative verbs in sftp are 'get' and 'put', as in:

* _get_ from remote to local
* _put_ from local to remote


**Speeding up**

You can use globbing to put/get a bunch of files all at once:

| command | explanation |
|----|----- |
| ```put foo*``` |  put all files in cwd starting with ```foo``` from local to remote |
| ```put *.c``` |  put all files in cwd ending with ```.c``` from local to remote |
| ```get foo*``` | get all files in cwd starting with ```foo```  from remote to local |
| ```get *.py``` | get all files in cwd ending with ```".py"```  from remote to local |

where
```cwd == "current working directory"```, at either end!
As you `put` and `get`, use `ls -lt` to see the state of your remote and local filesystems.

--- 
> **NOTE**
> * Use ```man sftp``` to see options on get and put.
>   - the -a option permits resuming a partial transfer
>   - the -r option permits transferring a directory
>   - the -p option permits transferring file permissions and timestamps
> * Use ``` ls -lt``` to see long listing of directory on remote host.

--- 

## rsync ##

A more powerful tool again for file transfer is `rsync`.  It can be restarted after an 
incomplete transfer, optionally compress the transfer, ensure that symbolic links, devices, attributes, permissions, ownerships, etc. are preserved, and much more.
See its man page for options and examples.

<table>
<tr>
    <th> command </th>
    <th> explanation </th>
</tr>
<tr>
    <td> <code>  rsync -avz host:src/bar /data/tmp </code> </td>
    <td> pull (get) from remote source</td>
</tr>
<tr>
    <td> <code> rsync -azv /path/to/file host:dest </code> </td>
    <td> push (put) to remote destination</td>
</tr>
</table>
