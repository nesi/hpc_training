---
layout: post
title: Submitting jobs with Slurm
permalink: /lessons/maui-and-mahuika/slurm
chapter: maui-and-mahuika
---

## Objectives

You will learn:

* how to write a Slurm job script
* how to submit jobs (serial, OpenMP, MPI and hybrid) to the different partitions
* how to check the status of running and completed jobs


**Content is currently under development. Check back soon.**

This page includes material from Jordi Blasco's [Introduction to Slurm documentation](https://wiki.auckland.ac.nz/download/attachments/63145549/introduction-slurm.pdf?api=v2) and the Slurm documentation at [CSCS](https://user.cscs.ch)

## How Slurm works

All NeSI systems use the Slurm batch scheduler for the submission, control and management of user jobs.

Slurm provides a rich set of features for organizing your workload and an extensive array of tools for managing your resource usage, however in normal interaction with the batch system you only need to know four basic commands:

 - `sbatch` - submit a batch script
 - `squeue` - check the status of jobs on the system
 - `scancel` - delete one of your jobs from the queue
 - `srun` - launch a process across multiple CPUs

Jobs in the Slurm queue have a priority which depends on several factors including size, age, owner, and the "partition" to which they belong. Each partition can be considered as an independent queue, with the slight complications that a job can be submitted to multiple partitions (though it will only *run* in one of them) and a compute node may belong to multiple partitions.

Reference information about Slurm can be found at:
 - `man slurm`
 - [https://slurm.schedmd.com/archive/slurm-17.02.9/](https://slurm.schedmd.com/archive/slurm-17.02.9/)


## Partitions

### Partitions on Mahuika

XXX ADD TABLE


## Checking the queue with squeue

To view all jobs in the queue:
```
squeue
```

To show just your jobs:
```
squeue -u $USER
```

You can provide a list of job IDs or user names, which is useful when there are many jobs running:
```
squeue -j <job_list>
```

The output will look more or less like this:
```
   JOBID      NAME     USER ST       TIME  NODES NODELIST(REASON)
61568899      wrap  apaw363 PD       0:00      1 (Resources)
61568901      wrap  apaw363 PD       0:00      1 (Resources)
61568970      wrap  apaw363 PD       0:00      1 (Resources)
```

The output shows the job state (column "ST") and various basic job specs, such as time spent running (column "TIME"), and the number of allocated nodes (column "NODES"). Additional job information can be provided, consult `man squeue` to find out more.

Here is a list of the most important job states:

| Short form | Long form | Meaning                                                                    |
|------------|-----------|----------------------------------------------------------------------------|
| PD         | Pending   | Job is queued and waiting for an allocation                                |
| R          | Running   | Job is running on the HPC                                                  |
| CA         | Cancelled | Job has been cancelled by user or sys admin                                |
| CD         | Completed | All processes in the job finished successfully (with an exit code of zero) |
| F          | Failed    | A process in the job failed (exit code not zero or other failure)          |
| TO         | Timeout   | Job reached its time limit and was terminated                              |

To cancel a job, use
```
scancel <job id>
```

## Submitting a batch script with sbatch

An appropriate Slurm job submission file for your parallel job is a shell script with a set of directives at the beginning. These directives are issued by starting a line with the string `#SBATCH`. A suitable batch script is then submitted to the batch system using the `sbatch` command.


### Standard job script directives

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
#SBATCH --hint=nomultithread    # don't use hyperthreading
```

### Hyperthreading

The default the layout of threads will be two per physical core, meaning [hyperthreading](https://en.wikipedia.org/wiki/Hyper-threading) is enabled. To turn hyperthreading off you can use the `srun` option `--hint=nomultithread`.  Like most `srun` options this can also be given to `sbatch` as a directive or command line option, and it will then be inherited (via the environment) by any occurrences of `srun` within the job.

```
#SBATCH --hint=nomultithread
```

Note: even if you turn off hyperthreading, Slurm will still report the total number of logical cores used.
You will only be charged for the number of physical cores used.

### Submitting a job


Consider a Slurm batch script named `run_helloworld.sl`:
```
#!/bin/bash
#SBATCH --job-name=hello
#SBATCH --account=nesi12345
#SBATCH --time=00:02:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=debug

srun echo "Hello, World!"
```

This batch script would be submitted to the Slurm queue with:
```
sbatch run_helloworld.sl
```
It will simply print out a string and exit.

`#SBATCH` directives are exactly equivalent to providing the same options on the `sbatch` command line, but have the advantage of repeatability and self-documentation, which are particularly useful if something goes wrong.  If both are provided then the command line option takes precedence. Slurm directives should be placed at the top of the submission script, before any other commands.

The Slurm "account" is just your NeSI project's code. If you only have one project then you don't need to specify it.

### Job output

The output of batch jobs is by default put into the file *slurm-\<SLURM_JOB_ID\>.out* where *\<SLURM_JOB_ID\>* is the Slurm batch job number of your job. The standard error will be put into a file called *slurm-\<SLURM_JOB_ID\>.err*: both files will be found in the directory from which you launched the job.

Note that the output file is created as soon as your job starts running, and the output from your job is placed in this file as the job runs, so that you can monitor your job's progress. Slurm performs file buffering by default when writing on the output files, so the output of your job will not appear in the output files immediately. If you want to override this behaviour, you should pass the option `-u` or `--unbuffered` to the `srun` command: the output will then appear in the file as soon as it is produced.

If you wish to change the default names of the output and error files, you can use the `--output` and `--error` directives in the batch script that you submit using the `sbatch` command, for example:

```
#SBATCH --output=hello_world_mpi.%j.o
#SBATCH --error=hello_world_mpi.%j.e
```

### Launching MPI, OpenMP or Hybrid job steps with srun

The `srun` command runs the executable you pass to it, within the resources allocated to your job.

* For MPI jobs, `srun` sets up the MPI runtime environment needed to run the parallel program, launching it on multiple CPUs, which can be on multiple different nodes. `srun` should be used in place of any other MPI launcher, such as `aprun` or `mpirun`.
* For OpenMP jobs you will need to set `--cpus-per-task` to a value larger than 1 and explicitly set the `OMP_NUM_THREADS` variable.

For example:
```
#!/bin/bash
#SBATCH --account=nesi12345
#SBATCH --ntasks=2            # number of MPI tasks
#SBATCH --cpus-per-task=8     # number of OpenMP threads per task
#SBATCH --hint=nomultithread

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
srun <your_app>
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
