---
layout: post
title: Kupe Data storage and transfer
---

You will learn how to transfer data to and from Kupe.

### Transferring small amounts of data

For small amounts of data, utilities such as SecureCopy (`scp`) can be used. `scp` should be readily available on a terminal on Linux and MacOS, or via [WinSCP](https://winscp.net/eng/download.php) and [MobaXterm](https://mobaxterm.mobatek.net) on Windows. Note that two-factor authentication will be required for file transfer sessions.

### Transferring large amounts of data (500GB or more)


Instructions on how to use [Globus Data Transfer Node (DTN)](../assets/resources/NeSI_DTN_End_User_Globus_2.00.pdf)

[Globus](https://www.globus.org) provides a fast file transfer service that is suitable for large data volumes. Globus requires two endpoints, on at your institution, and on the HPC. Data transfer sessions can be set up and monitored on the Globus webpage. Globus also provides APIs:

 * [Globus Auth](https://docs.globus.org/api/auth/)
 * [Globus Transfer API](https://docs.globus.org/api/transfer/)

There is a [Software Development Kit (SDK) in Python](http://globus-sdk-python.readthedocs.io/en/latest/) to work with the API.

### Automatic transfer between HPC sites

Automatic file space synchronisation between the Wellington and Auckland HPC sites using Spectrum Scale AFM (Active File Management) will make sure that user data will be accessible at both sites.
