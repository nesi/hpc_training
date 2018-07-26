---
layout: post
title: Migration from Pan to Mahuika
permalink: /lessons/maui-and-mahuika/migration
chapter: maui-and-mahuika
---

## Objectives

You will learn:

* where your migrated data will end up
* where you should be working until the migration from Pan is complete
* how Mahuika and Māui are different from Pan


**Content is currently under development. Check back soon.**


## Data Migration

Home directories from Pan have been copied into a subdirectory of your Mahuika home directory, and project directories copied into _/nesi/project_.  We will be synchronising these repeatedly while Pan is still available.

## Differences from Pan

Most Slurm batch scipts will require at least some changes to work on the new platform, so please review all of the following points.

### Filesystems

* On Pan the project directories were located under _/projects_, which was a symlink to _/gpfs1m/projects_. On Mahuika (and Māui) the project directories are located under _/nesi/project_, so any scripts referencing these directories must be updated.

* In addition to the project directory, each project has a "nobackup" directory found under _/nesi/nobackup_ which is faster but not backed up. Old files on _/nesi/nobackup_ are guarenteed to be deleted by the system when space is needed. 

* The per-job temporary directories SCRATCH_DIR, TMP_DIR and SHM_DIR on Pan are not provided on Mahuika.

  | Pan         | Mahuika/Maui                 | Comments                                                   |
  |-------------|:----------------------------:|:----------------------------------------------------------:|
  | SCRATCH_DIR | _/nesi/nobackup/projectcode_ | Use your project directory                                 |
  | TMP_DIR     | TMPDIR                       | Defaults to _/tmp_                                         |
  | SHM_DIR     | TMPDIR                       | No shared memory directory on Mahuika                      |

  As a substitute for SCRATCH_DIR you can use any location within your project's nobackup directory _/nesi/nobackup/projectcode_, eg: 

  ```
  SCRATCH_DIR=$(mktemp -d --tmpdir=/nesi/nobackup/$SLURM_JOB_ACCOUNT --template="scratch_${SLURM_JOB_ID}_XXX.tmp")
  ```

### Software

* Many older environment modules which were present on Pan have not been recreated on Mahuika. [See section software modules.](06-software-modules.md) 


* Locations of our installed software is different. This should not matter if you have been using environment modules.

### Hardware

* Ordinary Mahuika compute nodes have 36 CPU cores and 128 GB of memory, yielding only 3 GB per core rather than Pan's 7.5 GB per core. Please review your memory requests when submitting jobs.

* Mahuika uses the newer "Broadwell" and Maui the "Skylake" generation of Intel CPUs.  Pan's optional Slurm constraints "wm", "sb" and "avx" are obsolete on Mahuika/Maui. 

* Mahuika has only 8 GPU nodes. However, the GPUs are the more powerful Tesla P100.  They are accessed in the same way as on Pan with `--gres:gpu`.  It may be necessary to also specify `--partition gpu`.

* Mahuika has 5 "bigmem" nodes of 512 GB, and one "hugemem" node with 4 TB of memory.  These have to be specifically requested by telling _sbatch_ `--partition=bigmem`,  `--partition=bigmem` (for jobs shorter than 24 hours) or `--partition=hugemem`.  

### Job limits

* Jobs requesting a timelimit of more than 3 days have to be explictly submitted to the "long" partition, eg: `sbatch -p long ...`, while other ordinary jobs can be submitted to the "large" partition.  This kind of partitioning was more automated on Pan.

* Instead of Pan's little-used _debug_ partition Mahuika has a _debug_ QoS (Quality of Service) used like `sbatch --qos debug ...`.  Jobs requesting the _debug_ QoS can only request a maximum of 15 minutes and you can only execute one of them at a time.

### Accounts

* On Pan it was always necessary to specify your project account to _sbatch_.  This is no longer necessary on Mahuika if you have only one project.

### Licenses

* Some of our Slurm virtual licenses are obsolete and so have been removed: "io" because the filesystem bandwidth is considerably better than on Pan, "sci_matlab" and "eng_matlab" because their numbers of actual license tokens have been dramatically increased.

## The other machine - Māui.

Mahuika shares its filesystem with the co-located Cray XC supercomputer Māui, so if your work is suitable for running on Māui (ie: large MPI jobs) and you are granted an allocation of Māui CPU time then you will be able to access your data in the same locations from either machine. 
