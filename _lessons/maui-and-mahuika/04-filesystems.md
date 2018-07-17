---
layout: post
title: Filesystems, directories and quotas
permalink: /lessons/maui-and-mahuika/filesystems
chapter: maui-and-mahuika
---

## Objectives

You will learn:

* what the different filesystems are
* what they should be used for
* what the quotas are on the different filesystems

## Filesystems

The table below indicates the range of default allocations available in
_/home_, _/nesi/project_ and _/nesi/nearline_ filesystems (exceptions are
possible, based on project requirements).

<table border="1" cellspacing="0" cellpadding="0">
    <tbody>
        <tr>
            <td   valign="top">
                <p>
                    Filesystem
                </p>
            </td>
            <td   valign="top">
                <p>
                    /home
                </p>
            </td>
            <td   valign="top">
                <p>
                    /nesi/project
                </p>
            </td>
            <td   valign="top">
                <p>
                    /nesi/nobackup
                </p>
            </td>
            <td   valign="top">
                <p>
                    /nesi/nearline
                </p>
            </td>
        </tr>
        <tr>
            <td >
                <p>
                    Default Quota
                </p>
            </td>
            <td  >
                <p>
                    few GB (max. 100,000 files)
                </p>
            </td>
            <td  >
                <p>
                    up to TB (max 20,000 files / TB)
                </p>
            </td>
            <td  >
                <p>
                    No storage Quota (1 Million file limit)
                </p>
            </td>
            <td   >
                <p>
                    No Size Limit, 500,000 files, each no smaller than 5 MB
                </p>
            </td>
        </tr>
        <td  >
                <p>
                    Usage
                </p>
            </td>
            <td   >
                <p>
                    private data
                </p>
            </td>
            <td   >
                <p>
                    project related data storage
                </p>
            </td>
            <td   >
                <p>
                    job input / output workspace
                </p>
            </td>
            <td   >
                <p>
                    archive
                </p>
        </tr>
        <td  >
                <p>
                    Capacity
                </p>
            </td>
            <td   >
                <p>
                    175 TB
                </p>
            </td>
            <td   >
                <p>
                    1,590 TB
                </p>
            </td>
            <td   >
                <p>
                    4,400 TB
                </p>
            </td>
            <td   >
                <p>
                    &gt;100 PB (media funded by each project)
                </p>
        </tr>
        <tr>
            <td   valign="top">
                <p>
                    Access Speed
                </p>
            </td>
            <td   valign="top">
                <p>
                    Moderate
                </p>
            </td>
            <td   valign="top">
                <p>
                    Moderate
                </p>
            </td>
            <td   valign="top">
                <p>
                    Fast
                </p>
            </td>
            <td   valign="top">
                <p>
                   Slow. Only accessible via the Librarian Service.
                </p>
            </td>
        </tr>
        <tr>
            <td   valign="top">
                <p>
                    Expiration
                </p>
            </td>
            <td   valign="top">
                <p>
                    End of Project
                </p>
            </td>
            <td   valign="top">
                <p>
                    End of Project
                </p>
            </td>
            <td   valign="top">
                <p>
                    60 days (or earlier if space required)
                </p>
            </td>
            <td   valign="top">
                <p>
                    End of Project
                </p>
            </td>
        </tr>
        <tr>
            <td   valign="top">
                <p>
                    Data Backup
                </p>
            </td>
            <td   valign="top">
                <p>
                    Daily, last 10 versions retained for 90 days.
                </p>
            </td>
            <td   valign="top">
                <p>
                    Daily, last 10 versions retained for 90 days.
                </p>
            </td>
            <td  >
                <p>
                    None
                </p>
            </td>
            <td   valign="top">
                <p>
                    Replicated to offsite tape library
                </p>
            </td>
        </tr>
        <tr>
            <td   valign="top">
                <p>
                    Snapshots
                </p>
            </td>
            <td   valign="top">
                <p>
                    Daily (retention period, 7 days)
                </p>
            </td>
            <td   valign="top">
                <p>
                    None
                </p>
            </td>
            <td   valign="top">
                <p>
                    None
                </p>
            </td>
            <td   valign="top">
                <p>
                    None
                </p>
            </td>
        </tr>
    </tbody>
</table>

## Using the filesystems

### /home

* Every user has a home directory
* Private data that you don't need to share with anyone else (e.g. other project members and/or NeSI staff)
* Backed up

### /nesi/project

* Every project has a directory on this filesystem: _/nesi/project/<project-id\>_
* Critical data (time enduring)
* Source code, shared data
* Recommended for building software
* Backed up

### /nesi/nobackup

* Every project has a directory on this filesystem: _/nesi/nobackup/<project-id\>_
* This is where most data should be read/written and is the highest performance filesystem
* Actively managed to remove unused data and not backed up
* Advise to move valuable data to the /nesi/project filesystem as soon as the batch jobs are completed

### /nesi/nearline

* Data cache for HSM
* Holds the records of all data written to tape via the librarian service
