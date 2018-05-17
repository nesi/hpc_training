---
layout: post
title: Migration from Pan
permalink: /lessons/maui-and-mahuika/migration
chapter: maui-and-mahuika
---

## Objectives

You will learn:

* where your migrated data will end up
* where you should be working until the migration from Pan is complete
* how Mahuika and Māui are different from Pan


**Content is currently under development. Check back soon.**


Data Migration

Home directories from pan have been copied to XXX and project directories to XXX.  We will be synchronising these repeatedly while Pan is still available, so it is best to work in your perminant Mahuika directories: XXX and XXX.

Differences from Pan

* Due to two-factor authentication and the "lander" node, ssh and scp are more complicated to set up, see XXX.

* The Pan _/projects_ directory was a symlink to _/gpfs1m/projects_, _/gpfs1m_ being the root of Pan's entire main GPFS filesystem.  There was never actually a need to mention _/gpfs1m_, however it often appeared in output and so found its way into many batch scripts.  On Mahuika _/gpfs1m_ does not exist, so use _/projects_. 

* Mahuikia uses the "Broadwell" generation of Intel CPUs, newer than anything on Pan.  This makes Pan's optional Slurm constraints "wm", "sb" and "avx" obsolete.  The build nodes have different names too XXX

* The filesystem bandwidth is considerably better than on Pan, so the "io" virtual license is also obsolete.

* The per-job temporary directories SCRATCH_DIR, TMP_DIR and SHM_DIR are not provided on Mahuika.  Since most of its compute nodes do not have local disks there would not be any point in TMP_DIR.  As a replacement for SCRATCH_DIR you can use XXX.

* On Pan it was always necessary to specify your project to _sbatch_.  That is still a good idea, but if you only have one project then it isn't strictly necessary on Mahuika as Slurm has a concept of "default account".

* Many older environment modules which were present on Pan have not been recreated on Mahuika. Use `module spider` to discover if a newer version is present, and if stuck then please contact us. 

* Locations of our installed software will be entirely different, though if you have been using environment modules correctly this will not affect you.

* Ordinary Mahuika compute nodes have 36 CPU cores and 128 GB of memory, so only 3.5 GB per core rather than Pan's 7.5 GB per core.

* Mahuika has only 8 GPU nodes however the GPUs are the more powerful Tesla P100.  They are accessed in the same way as on Pan XXX ? XXX with `-gres:gpu`.

* Mahuika has XXX "bigmem" nodes of 512 GB, and one "hugemem" node with 4 TB of memory, which has to be specifically requested by telling _sbatch_ `--partition=hugemem`.

The other machine - Māui.

Mahuika shares its filesystem with the co-located Cray XC supercomputer Māui, so if your work is suitable for running on Māui (ie: large MPI jobs) and you are granted an allocation of Māui CPU time then you will be able to access your data in the same locations from either machine. 
