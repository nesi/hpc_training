---
layout: post
title: Running jobs with Slurm
permalink: /lessons/maui-and-mahuika/slurm
chapter: maui-and-mahuika
---

## Objectives

You will learn:

* what partitions are and which partitions are available on Mahuika
* how to write Slurm scripts
* how to submit jobs
* how to check the status of running and completed jobs


## Slurm basics

All NeSI systems use the Slurm batch scheduler for the submission, control and management of user jobs.

Slurm provides a rich set of features for organising your workload and an extensive array of tools for managing your resource usage. In most cases you need to know the commands:

 - `sbatch` - submit a batch script
 - `squeue` - check the status of jobs on the system
 - `scancel` - delete one of your jobs from the queue
 - `srun` - launch a process across multiple CPUs
 - `sinfo` - view information about Slurm nodes and partitions
 - `sacct` - display accounting data for all jobs and job steps in the Slurm job accounting log or Slurm 

Reference information about Slurm can be found at:
 - `man slurm`
 - [https://slurm.schedmd.com/](https://slurm.schedmd.com/)


## Partitions

Jobs in the Slurm queue have a priority which depends on several factors including size, age, owner, and the "partition" to which they belong. Each partition can be considered as an independent queue, with the slight complications that a job can be submitted to multiple partitions (though it will only *run* in one of them) and a compute node may belong to multiple partitions.

### Partitions on Mahuika

**Important Note:** Slurm configuration is not yet complete on Mahuika and so this page is subject to change, particularly numerical values.

| Partition	Name | Time limit	| CPU cores	| Max cores per user	| RAM / core | Purpose |
| ----------|------------|-----------|--------------------|------------|---------------- |
| large |	3 days	| 8424	| 1024	| 3 GB | Default partition, allows large core count jobs. |
| long |	3 weeks	| 1872	| 720	| 3 GB | Corrals long-duration jobs into a subset of the compute nodes. |
| prepost	| 3 hours |	36	| 4	| 15 GB | Short jobs only.  More memory per CPU. |
| bigmem	| 3 days	| 108	| 72	| 15 GB | Standard partition for all other “large memory” jobs. | 
| hugemem	| 3 days	| 64	| 64	| 62 GB | The 4TB node – when it is available for batch processing. |
| gpu	| 3 days	| 12	| 4 + 2 GPUs	| 3 GB | 2 GPGPUs per node. |


### Quality of Service

In addition to the partitions, each job has a "QoS", with the default QoS for a job being determined by the allocation class of its project. Specifying `--qos=debug` will override that and give the job very high priority, but is subject to strict limits: 15 minutes per job, and only 1 job at a time per user.


## Slurm scripts

Slurm scripts are text files you will need to create in order to submit a job to the scheduler. Slurm scripts start with `#!/bin/bash` and contain set of directives (start with `#SBATCH `, followed by commands (`srun`): 

```
#!/bin/bash
#SBATCH --job-name=JobName      # job name (shows up in the queue)
#SBATCH --account=nesi99999     # Project Account
#SBATCH --time=08:00:00         # Walltime (HH:MM:SS)
#SBATCH --mem-per-cpu=4096      # memory/cpu (in MB)
#SBATCH --ntasks=2              # number of tasks (e.g. MPI)
#SBATCH --cpus-per-task=4       # number of cores per task (e.g. OpenMP)
#SBATCH --partition=long        # specify a partition
#SBATCH --qos=debug             # debug jobs have increased priority but tighter restrictions
#SBATCH --hint=nomultithread    # don't use hyperthreading

srun [options] <executable> [options]
```
Not all directives need to be specified, just the ones you need. 

### Launching job steps with srun

The `srun` command runs the executable along with its options, within the resources allocated to the job.

For MPI jobs, `srun` sets up the MPI runtime environment needed to run the parallel program, launching it on multiple CPUs, which can be on different nodes. `srun` should be used in place of any other MPI launcher, such as `aprun` or `mpirun`.

### Commonly used Slurm environment variables

These can be useful within Slurm scripts:

- `$SLURM_JOB_ID` (job id)
- `$SLURM_NNODES` (number of nodes)
- `$SLURM_NTASKS` (number of MPI tasks)
- `$SLURM_CPUS_PER_TASK` (CPUs per MPI task)
- `$SLURM_SUBMIT_DIR` (directory job was submitted from)
- `$SLURM_ARRAY_JOB_ID` (job id for the array)
- `$SLURM_ARRAY_TASK_ID` (job array index value)

### OpenMP jobs

For OpenMP jobs you will need to set `--cpus-per-task` to a value larger than 1.  Our Slurm prolog will then set OMP_NUM_THREADS equal to that number.  


### Hyperthreading

[Hyperthreading](https://en.wikipedia.org/wiki/Hyper-threading) is enabled on NeSI's platforms.
By default, Slurm schedules multithreaded jobs using hyperthreads (logical cores, or "CPUs" in Slurm nomenclature), of which there are two for each physical core, so 72 and 80 per node on Mahuika and Māui, respectively.
To turn hyperthreading off you can use the `srun` option `--hint=nomultithread`.  Like most `srun` options this can also be given to `sbatch` as a directive or command line option, and it will then be inherited (via the environment) by any occurrences of `srun` within the job.

```
#SBATCH --hint=nomultithread
```

Even though hyperthreading is enabled, the resources will generally be allocated to jobs and their tasks at the level of a physical core. Two different jobs will not share a physical core. For example, a job requesting resources for three hyperthreads will be allocated two full physical cores.

**Important:** Hyperthreading can be beneficial for some codes, but it can also degrade performance in other cases. We therefore recommend to run a small test job with and without hyperthreading to determine the best choice.

Because Slurm is configured to allow the use logical cores you will notice that even a serial job reports using 2 CPUs.  These numbers will be halved before being used in our project accounting, which is still based on physical core hours.

### Mahuika Infiniband Islands

Mahuika's network consists of a number of Infiniband Islands, each containing 26 nodes or 936 physical cores. Parallel jobs that run entirely within an InfiniBand Island will achieve better application scaling performance than those that cross InfiniBand Island boundaries.

Users can request that the job run within an InfiniBand Island by adding the `sbatch` flag `#SBATCH --switches=1` to their batch script. We advise that you manually set a maximum waiting time for the selected number of switches, e.g. `#SBATCH --switches=1@00:01:00` will make the scheduler wait for maximum one hour before ignoring the switches request.


## Submitting a job

Use `sbatch <script>` to submit the job. All Slurm directives can alternatively be specified at the command line, e.g. `sbatch --account=nesi12345 <script>`.

### Try submitting a simple job

Submit job `helloworld.sl`:
```
#!/bin/bash
#SBATCH --job-name=hello
#SBATCH --time=00:02:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

srun echo "Hello, World!"
```
with `sbatch --account=nesi12345 helloworld.sl` where nesi12345 is your NeSI project's code. If you only have one project then you don't need to specify it.

## Checking completed jobs with sacct

Another useful Slurm command is `sacct` which retrieves information about completed jobs. For example:

```
sacct -j 14309
```
where the argument passed to `-j` is the job ID, will show us something like:

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
