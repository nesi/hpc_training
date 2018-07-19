---
layout: post
title: Running jobs with Slurm
permalink: /lessons/maui-and-mahuika/slurm
chapter: maui-and-mahuika
---

## Objectives

You will learn:

* how to modify your Slurm scripts to run on Mahuika
* how to check the status of running and completed jobs


**Content is currently under development. Check back soon.**

## Slurm basics

All NeSI systems use the Slurm batch scheduler for the submission, control and management of user jobs.

Slurm provides a rich set of features for organizing your workload and an extensive array of tools for managing your resource usage, however in normal interaction with the batch system you only need to know four basic commands:

 - `sbatch` - submit a batch script
 - `squeue` - check the status of jobs on the system
 - `scancel` - delete one of your jobs from the queue
 - `srun` - launch a process across multiple CPUs

Jobs in the Slurm queue have a priority which depends on several factors including size, age, owner, and the "partition" to which they belong. Each partition can be considered as an independent queue, with the slight complications that a job can be submitted to multiple partitions (though it will only *run* in one of them) and a compute node may belong to multiple partitions.

Reference information about Slurm can be found at:
 - `man slurm`
 - [https://slurm.schedmd.com/](https://slurm.schedmd.com/)


## Partitions

### Partitions on Mahuika

**Important Note:** Slurm configurations is not yet complete on Mahuika and so this page is subject to change, particularly numerical values.

| Name of Partition	| Maximum time limit	| CPU cores	| Maximum cores per user	| Brief description / Purpose |
| ------------------|--------------------|-----------|------------------------|---------------------------- |
| large |	3 days	| 8424	| 1024	| Standard partition, allows large core count jobs. |
| long |	3 weeks	| 1872	| 720	| Standard partition to corral long-duration jobs. |
| prepost	| 2 hours |	36	| 2	| Short jobs only.  More memory per CPU. |
| bigmem	| 6 days	| 108	| 108	| Standard partition for all other “large memory” jobs. | 
| hugemem	| 1 day	| 64	| 64	| The 4TB node – when it is available for batch processing. |
| gpu	| 1 day	| 6	| 2	| 2 GPGPUs per node. |

### Quality of Service

Orthogonal to the partitions, each job has a "QoS", with the default QoS for a job being determined by the allocation class of its project. Specifying `--qos=debug` will override that and give the job very high priority, but is subject to strict limits: 15 minutes per job, and only 1 job at a time per user.


## Modifying your Slurm scripts

You will need to modify your Slurm scripts to run on the new platforms.

### Hyperthreading

[Hyperthreading](https://en.wikipedia.org/wiki/Hyper-threading) is enabled on NeSI's platforms.
By default, Slurm schedules hyperthreads (logical cores, or "CPUs" in Slurm nomenclature), of which there are 72 and 80 per node on Mahuika and Maui respectively.
To turn hyperthreading off you can use the `srun` option `--hint=nomultithread`.  Like most `srun` options this can also be given to `sbatch` as a directive or command line option, and it will then be inherited (via the environment) by any occurrences of `srun` within the job.

```
#SBATCH --hint=nomultithread
```

Even though hyperthreading is enabled, the resources will generally be allocated to jobs at the level of a physical core. Two different jobs will not share a physical core. For example, a job requesting resources for three tasks on a hyperthreading node will be allocated two full physical cores.

### Mahuika Infiniband Islands

Mahuika's network consists of a number of Infiniband Islands, each containing 26 nodes or 936 physical cores. Parallel jobs that run entirely within an InfiniBand Island will achieve better application scaling performance than those that cross InfiniBand Island boundaries.

Users can request that the job run within an InfiniBand Island by adding the `sbatch` flag `#SBATCH --switches=1` to their batch script. We advise that you manually set a maximum waiting time for the selected number of switches, e.g. `#SBATCH --switches=1@00:01:00` will make the scheduler wait for maximum one hour before ignoring the switches request.

### OpenMP jobs

For OpenMP jobs you will need to set `--cpus-per-task` to a value larger than 1 and explicitly set the `OMP_NUM_THREADS` variable.
For example, add the following line after the `#SBATCH` directives and before you run your program with `srun`:

```
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
```


## Submitting a job

### Common job script directives

Some standard Slurm directives (not all need to be specified, just the ones you need):

```
#SBATCH --job-name=JobName      # job name (shows up in the queue)
#SBATCH --account=nesi99999     # Project Account
#SBATCH --time=08:00:00         # Walltime (HH:MM:SS)
#SBATCH --mem-per-cpu=4096      # memory/cpu (in MB)
#SBATCH --ntasks=2              # number of tasks (e.g. MPI)
#SBATCH --cpus-per-task=4       # number of cores per task (e.g. OpenMP)
#SBATCH --nodes=1               # number of nodes
#SBATCH --exclusive             # node should not be shared with other jobs
#SBATCH --partition=long        # specify a partition
#SBATCH --qos=debug             # debug jobs have increased priority but tighter restrictions
#SBATCH --hint=nomultithread    # don't use hyperthreading
```

### Commonly used Slurm environment variables

These can be useful within Slurm job scripts:

- `$SLURM_JOB_ID` (job id)
- `$SLURM_NNODES` (number of nodes)
- `$SLURM_NTASKS` (number of MPI tasks)
- `$SLURM_CPUS_PER_TASK` (CPUs per MPI task)
- `$SLURM_SUBMIT_DIR` (directory job was submitted from)
- `$SLURM_ARRAY_JOB_ID` (job id for the array)
- `$SLURM_ARRAY_TASK_ID` (job array index value)


### Launching job steps with srun

The `srun` command runs the executable you pass to it within the resources allocated to your job.

For MPI jobs, `srun` sets up the MPI runtime environment needed to run the parallel program, launching it on multiple CPUs, which can be on multiple different nodes. `srun` should be used in place of any other MPI launcher, such as `aprun` or `mpirun`.

### Try submitting a simple job

Submit a simple job to make sure everything is working. Consider a Slurm batch script named `run_helloworld.sl`:
```
#!/bin/bash
#SBATCH --job-name=hello
#SBATCH --account=nesi12345
#SBATCH --time=00:02:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

srun echo "Hello, World!"
```

The Slurm "account" is just your NeSI project's code. If you only have one project then you don't need to specify it.

Submit the job to the Slurm queue with:
```
sbatch run_helloworld.sl
```
It will simply print out a string to the Slurm output file and exit.


## Checking completed jobs with sacct

Another useful Slurm command is `sacct` which retrieves information about completed jobs. For example:

```
sacct -j 14309
```

Will show us something like:

```
       JobID    JobName  Partition    Account  AllocCPUS      State ExitCode
------------ ---------- ---------- ---------- ---------- ---------- --------
14309        problem.sh       NeSI  nesi99999         80  COMPLETED      0:0
14309.batch       batch             nesi99999         80  COMPLETED      0:0
14309.0         yourapp             nesi99999         80  COMPLETED      0:0
```

By default `sacct` will list all of your jobs which were (or are) running on the current day.  Each job will show as more than one line (unless `-X` is specified): an initial line for the job as a whole, and then an additional line for each job step, i.e.: the batch process which is your executing script, and then each of the `srun` commands it executes.

By changing the displayed columns you can gain information about the CPU and memory utilisation of the job, for example

```
sacct -j 14309 --format=jobid,jobname,elapsed,avecpu,totalcpu,alloccpus,maxrss,state
```

```
      JobID    JobName    Elapsed     AveCPU   TotalCPU  AllocCPUS     MaxRSS      State
------------ ---------- ---------- ---------- ---------- ---------- ---------- ----------
14309        problem.sh   00:12:42             00:00.012         80             COMPLETED
14309.batch       batch   00:12:42   00:00:00  00:00.012         80      1488K  COMPLETED
14309.0         yourapp   00:12:41   00:12:03   16:00:03         80    478356K  COMPLETED
```
