---
layout: post
title: Differences between Kupe and DevSys
permalink: /dev/kupe-devsys/
---

If you worked on the XC50 development system, you will find that a few things are different on Kupe:

1. Kupe has an `elogin` node with a Skylake CPU. The `clogin` node on the development (dev) machine, on the other hand, has a Broadwell CPU and this requires users to "cross-compile" for Skylake. Cross-compiled code does not run on the `clogin` node - it either crashes with an "illegal instruction" error, or with an error message if it was compiled with the Intel compilers. This can be problematic for some build systems that run small test executables during the build process. Kupe login nodes do not require cross-compilation.

2. Kupe has multi-purpose nodes and virtual lab nodes, all equipped with Skylake processors. These do not exist on the dev system.

3. The Kupe `elogin`, multi-purpose, and virtual lab nodes all have native Spectrum Scale access.  The `clogin` node on the dev system does not have native Spectrum Scale access, but uses Cray DVS instead. This leads to somewhat lower IO performance, and it causes a problem when writing HDF5 and netCDF4 files due to an unsupported file locking mechanism. However, keep in mind that any code that runs on Kupe's XC50 compute nodes will still use Cray DVS (there are workarounds for the HDF5 problem).

You will also find that many things are the same:

1. Kupe uses the same programming environment as the development system
2. The XC50 compute nodes on Kupe and on the development system are exactly the same
3. Both machines use global file systems
