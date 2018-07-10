---
layout: post
title: File systems, directories and quotas
permalink: /lessons/maui-and-mahuika/file-systems
chapter: maui-and-mahuika
---

## Objectives

You will learn:

* what the different file systems are
* what they should be used for
* what the quotas are on the different file systems

## File systems

<table border="1" cellspacing="0" cellpadding="0">
    <tbody>
        <tr>
            <td width="144" colspan="2" valign="top">
                <p>
                    Filesystem
                </p>
            </td>
            <td width="115" valign="top">
                <p>
                    /home
                </p>
            </td>
            <td width="115" valign="top">
                <p>
                    /nesi/project
                </p>
            </td>
            <td width="115" valign="top">
                <p>
                    /nesi/nobackup
                </p>
            </td>
            <td width="115" valign="top">
                <p>
                    /nesi/nearline
                </p>
            </td>
        </tr>
        <tr>
            <td width="62" rowspan="2">
                <p>
                    Default
                </p>
                <p>
                    Quota
                </p>
            </td>
            <td width="82">
                <p>
                    Mahuika
                </p>
            </td>
            <td width="115">
                <p>
                    10 to 40 GB (and 100,000 files)
                </p>
            </td>
            <td width="115">
                <p>
                    10 GB to 20 TB (max 20,000 files / TB)
                </p>
            </td>
            <td width="115">
                <p>
                    No storage Quota (1 Million file limit)
                </p>
            </td>
            <td width="115" rowspan="2">
                <p>
                    No Size Limit, 500,000 files, each no smaller than 5 MB
                </p>
            </td>
        </tr>
        <tr>
            <td width="82">
                <p>
                    Maui
                </p>
            </td>
            <td width="115">
                <p>
                    10 to 100 GB (and 100,000 files)
                </p>
            </td>
            <td width="115">
                <p>
                    100 GB to 50 TB (max 20,000 files / TB)
                </p>
            </td>
            <td width="115">
                <p>
                    No storage Quota (1 Million file limit)
                </p>
            </td>
        </tr>
        <tr>
            <td width="62" rowspan="2">
                <p>
                    Capacity
                </p>
            </td>
            <td width="82" valign="top">
                <p>
                    Mahuika
                </p>
            </td>
            <td width="115" valign="top">
                <p>
                    75TB
                </p>
            </td>
            <td width="115" valign="top">
                <p>
                    675TB
                </p>
            </td>
            <td width="115" rowspan="2">
                <p>
                    4,400TB
                </p>
            </td>
            <td width="115" rowspan="2">
                <p>
                    &gt;100 PB (media funded by each project)
                </p>
            </td>
        </tr>
        <tr>
            <td width="82" valign="top">
                <p>
                    Maui
                </p>
            </td>
            <td width="115" valign="top">
                <p>
                    100TB
                </p>
            </td>
            <td width="115" valign="top">
                <p>
                    915TB
                </p>
            </td>
        </tr>
        <tr>
            <td width="144" colspan="2" valign="top">
                <p>
                    Expiration
                </p>
            </td>
            <td width="115" valign="top">
                <p>
                    End of Project
                </p>
            </td>
            <td width="115" valign="top">
                <p>
                    End of Project
                </p>
            </td>
            <td width="115" valign="top">
                <p>
                    60 days (or earlier if space required)
                </p>
            </td>
            <td width="115" valign="top">
                <p>
                    End of Project
                </p>
            </td>
        </tr>
        <tr>
            <td width="144" colspan="2" valign="top">
                <p>
                    Data Backup
                </p>
            </td>
            <td width="115" valign="top">
                <p>
                    Daily, last 10 versions retained for 90 days.
                </p>
            </td>
            <td width="115" valign="top">
                <p>
                    Daily, last 10 versions retained for 90 days.
                </p>
            </td>
            <td width="115">
                <p>
                    None
                </p>
            </td>
            <td width="115" valign="top">
                <p>
                    Replicated to offsite tape library
                </p>
            </td>
        </tr>
        <tr>
            <td width="144" colspan="2" valign="top">
                <p>
                    Snapshots
                </p>
            </td>
            <td width="115" valign="top">
                <p>
                    Daily (retention period, 7 days)
                </p>
            </td>
            <td width="115" valign="top">
                <p>
                    None
                </p>
            </td>
            <td width="115" valign="top">
                <p>
                    None
                </p>
            </td>
            <td width="115" valign="top">
                <p>
                    None
                </p>
            </td>
        </tr>
        <tr>
            <td width="144" colspan="2" valign="top">
                <p>
                    Access Speed
                </p>
            </td>
            <td width="115" valign="top">
                <p>
                    Moderate
                </p>
            </td>
            <td width="115" valign="top">
                <p>
                    Moderate
                </p>
            </td>
            <td width="115" valign="top">
                <p>
                    Fast
                </p>
            </td>
            <td width="115" valign="top">
                <p>
Slow. Only accessible via the Librarian Service.
                </p>
            </td>
        </tr>
    </tbody>
</table>

## Using the filesystems

### /home

* Private data that you don't need to share with anyone else (e.g. other project members and/or NeSI staff)
* Backed up

### /nesi/project

* Critical data (time enduring)
* Source code, shared data
* Recommended for building software
* Backed up

### /nesi/nobackup

* This is where most data should be read/written and is the highest performance filesystem
* Actively managed to remove unused data and not backed up
* Advise to move valuable data to the /nesi/project filesystem as soon as the batch jobs are completed

### /nesi/nearline

* Data cache for HSM
* Holds the records of all data written to tape via the librarian service
