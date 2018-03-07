---
layout: post
title: Filesystems and their use
permalink: /lessons/kupe-filesystems/
chapter: kupe
---



#### NeSI and NIWA research users

Kupe provides users with the following filesystems. *As of 19 Jan 2018 only /home and /nesi/nobackup are active.*

| File Space | Backed Up | Maximum <sup>[0](#0)</sup> I/O Bandwidth(GB/s) | Total Capacity | Access | Quota | Usage |
| --- | --- | --- | --- | --- | --- | --- |
| /home | Y | 15 | 100 TB | Personal | Y | Source code, control data, documentation etc. |
| /nesi/project | Y | 15 | 500 TB | Group | Y | Critical data (time enduring), Data collections, shared reference data, source code, shared data etc. |
| /nesi/nobackup<sup>[1](#1)</sup>| N | 70 | 2500 TB | Group | Y | Where most output should be read / written – the highest performance filesystem. Actively managed to remove unused data. |
| /nesi/nearline | HSM<sup>[2](#2)</sup> | 15 | 400 TB cache to ~50PB tape storage | N/A | Y | Data cache for HSM. Holds the records of all data written to tape via the librarian<sup>[3](#3)</sup> Service. |

<sup><a name="0">[0]</sup>The total I/O bandwidth to disk is 70 GB/s, but this is spread across all five filesystems on the Kupe storage. However, the storage has been configured so as to provide the highest bandwidth to the nobackup filesystem. All user filesystems also include an additional SSD resource that can be used to optimise jobs that have random I/O access patterns.</a>

<sup><a name="1"> [1]</sup>
The &quot;nobackup&quot; filesystem is the scratch filesystem, and provides the highest performance and the largest space. This is where you should do most of your work. Similarly, big analysis jobs would run in this filesystem – perhaps following the recovery of large volumes of data from the nearline filesystem.  This space will be actively managed (by a process yet to be agreed, and advised). Files will routinely be deleted to maintain large amounts of free space needed to support the envisioned workflows. Critical, actively used data that you wish to retain should be stored in either the /project or /nearline filesystems. </a>

<sup><a name="2">[2]</sup>
HSM means Hierarchical Storage Management. Large datasets not currently required should be moved to /nearline. Two copies of these datasets will be held, one in Auckland and one in Wellington.</a>

<sup><a name="3">[3]</sup>
User&#39;s will employ a &quot;librarian&quot; service to query the data they have stored on /nearline, to &quot;put&quot; data into /nearline and to &quot;get&quot; data from /nearline. All FitzRoy HSM data will be available on Kupe once the librarian service is available. In the interim, if users need to recover FitzRoy nearline data, they should enter a support ticket.</a>

## NIWA Research and Operational users

The following file systems used solely by NIWA:

| File Space | Backed Up | Maximum I/O Bandwidth(GB/s) | Total Capacity(TB) | Access | Quota | Usage |
| --- | --- | --- | --- | --- | --- | --- |
| /devel | Y | 35 | 50 | Group | Y | Science development |
| /test | Y | 35 | 400 | Group | Y | Parallel Testing of forecast system science |
| /archive | Y | 35 | 20 | Group | Y | Rolling archive of forecast system outputs and restart files |
| /oper | Y | 35 | 600 | Group | Y | Operational forecast system |
