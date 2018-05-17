---
layout: post
title: Slurm job scheduler
permalink: /lessons/kupe-slurm/
chapter: kupe
---

This page includes material from Jordi Blasco's [Introduction to Slurm documentation](https://wiki.auckland.ac.nz/download/attachments/63145549/introduction-slurm.pdf?api=v2) and the Slurm documentation at [CSCS](https://user.cscs.ch)

# Slurm

All NeSI systems use the Slurm batch scheduler for the submission, control and management of user jobs.

Slurm provides a rich set of features for organizing your workload and an extensive array of tools for managing your resource usage, however in normal interaction with the batch system you only need to know four basic commands:


Additional information can be found at:
 - https://slurm.schedmd.com/archive/slurm-17.02.9/
 - https://support.nesi.org.nz/hc/en-gb/articles/115000194910-Submitting-Slurm-Jobs-on-Pan

Adapted from Jordi Blasco's [Introduction to Slurm documentation](https://wiki.auckland.ac.nz/download/attachments/63145549/introduction-slurm.pdf?api=v2)

## How Slurm works

Jobs in the Slurm queue have a priority which depends on several factors including size, age, owner, and the "partition" to which they belong. Each partition can be considered as an independent queue, with the slight complications that a job can be submitted to multiple partitions (though it will only *run* in one of them) and a compute node may belong to multiple partitions.

 - `sbatch` - submit a batch script
 - `squeue` - check the status of jobs on the system
 - `scancel` - delete one of your jobs from the queue
 - `srun` - launch a process across multiple CPUs


Reference information about Slurm can be found at:
 - `man slurm`
 - https://slurm.schedmd.com/archive/slurm-17.02.9/

## Getting started with Slurm on Kupe

To use the Slurm scheduler on Kupe, you will first need to load the `slurm` module:
```
module load slurm
```
You could add this line to your `.profile` if you don't want to load the module on every login, though we do plan to remove the need to do this step at all.

## Submitting a one-line job with sbatch

Slurm works like any other scheduler - you can submit jobs to the queue, and Slurm will run them for you when the resources that you requested become available. Jobs are usually defined using a job script, although you can also submit jobs without a script, directly from the command line:

```
sbatch -A <project_code> -t 10 -p NeSI --wrap  "echo hello world"
sbatch --account <project_code> --time 10 --partition=NeSI --wrap "echo hello world"
```

These two variants of the command are equivalent - Slurm offers short and long versions of many options (although there is no short form of `--wrap`. The option `-t` or `--time` sets a limit on the total run time of the job allocation.

The Slurm *account* is just your NeSI project's code. If you only have one project then you don't need to specify it.

### Partitions

At present it is also necessary to specify which Slurm *partition* the job will run in.  For any project without the prefix "niwap" the correct partition will be "NeSI". This includes most projects with the prefix "niwa", which are NIWA-as-NeSI-collaborator projects.  We do hope that it will not be necessary to specify the partition in the long term, since it is determined by the account you specify anyway.

There is also a "Debug" partition and a "NeSI_Forage" partition available to NeSI projects.  Please check back here for documentation on these later.  Beware that at present jobs longer than 10 minutes submitted to Debug will submit OK but then never start, while jobs submitted to "NeSI_Forage" jobs may be terminated by Slurm so that other jobs can run.  Finally, there are partitions "NIWA_Research", "NIWA_Forage" and "Operations" which are not accessible by jobs which belong to NeSI projects.

## Submitting a batch script with sbatch

An appropriate Slurm job submission file for your parallel job is a shell script with a set of directives at the beginning. These directives are issued by starting a line with the string "#SBATCH". A suitable batch script is then submitted to the batch system using the `sbatch` command.

Consider a Slurm batch script named `run_simplempi.sl`:
```
cat run_simplempi.sl
```

```
#!/bin/bash
#SBATCH --job-name=simplempi
#SBATCH --time=00:02:00
#SBATCH --nodes=3
#SBATCH --account=niwa12345
#SBATCH --partition=NeSI
#SBATCH --cpus-per-task=1

srun simpleMpiProgram
```

This batch script would be submitted to the Slurm queue with:
```
sbatch run_simplempi.sl
```

That would run `simpleMpiProgram` on all the CPUs of 3 different compute nodes, with each MPI task having 1 CPU core.

#SBATCH directives are exactly equivalent to providing the same options on the `sbatch` command line, but have the advantage of repeatability and self-documentation, which are particularly useful if something goes wrong.  If both are provided then the command line option takes precedence. As a note for LoadLeveler users: Slurm expects directives to come first in a submission script, so don't insert any commands above the directives block.

The Slurm "account" is just your NeSI project's code. If you only have one project then you don't need to specify it.

### Launching MPI job steps with srun

The `srun` command in the script above sets up the MPI runtime environment need to run the parallel program, launching it on multiple CPUs which can be on multiple different nodes. `srun` should be used in place of any other MPI launcher such as *aprun* or *mpirun*.

On Kupe the default the layout of threads will be two per physical core, meaning hyperthreading is enabled. To turn hyperthreading off you can use the `srun` option `--hint=nomultithread`.  Like most `srun` options this can also be given to `sbatch` as a directive or command line option, and it will then be inherited (via the environment) by any occurrences of `srun` within the job.

### Launching OpenMP or Hybrid job steps with srun

For OpenMP jobs you will need to set `--cpus-per-task` to a value larger than 1 and explicitly set the
`OMP_NUM_THREADS` variable. For example:
```
#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --hint=nomultithread

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
srun <your_app>
```

### sbatch customisation on Kupe

On Kupe we have set the environment variable `SBATCH_EXPORT=NONE`.  This has the effect of telling `sbatch` to not copy the environment from where you submit the job, but rather start the job with a fresh copy of your login environment. This is required when submitting jobs from one operating system to another as users of the *kupe_mp* may do, but has the consequence that you must load any required environment module from inside the job script, and not just before you submit it.  As with the use of #SBATCH directives this makes the job more self-documenting and so helps us when something goes wrong and needs diagnosing, but if you wish for the convenience of one-line module-using jobs then you can do `export SBATCH_EXPORT=ALL`.


### Commonly used Slurm environment variables

These can be useful within Slurm job scripts:

- $SLURM_JOBID (job id)
- $SLURM_NNODES (number of nodes)
- $SLURM_NTASKS (number of MPI tasks)
- $SLURM_CPUS_PER_TASK (CPUs per MPI task)
- $SLURM_SUBMIT_DIR (directory job was submitted from)
- $SLURM_ARRAY_JOB_ID (job id for the array)
- $SLURM_ARRAY_TASK_ID (job array index value)

## Output
The output of batch jobs is by default put into the file slurm-<SLURM_JOB_ID>.out where <SLURM_JOB_ID> is the Slurm batch job number of your job. The standard error will be put into a file called slurm-<SLURM_JOB_ID>.err: both files will be found in the directory from which you launched the job.

Note that the output file is created as soon as your job starts running, and the output from your job is placed in this file as the job runs, so that you can monitor your job's progress. Slurm performs file buffering by default when writing on the output files, so the output of your job will not appear in the output files immediately. If you want to override this behaviour, you should pass the option -u or --unbuffered to the *srun* command: the output will then appear in the file as soon as it is produced.

If you wish to change the default names of the output and error files, you can use the --output and --error directives in the batch script that you submit using the sbatch command, for example:

```
#SBATCH --output=hello_world_mpi.%j.o
#SBATCH --error=hello_world_mpi.%j.e
```

## Calling srun directly

`srun` is usually only used from within a job script.  In that environment it notices and uses the Slurm allocation created for its enclosing job.  When executed outside of any Slurm allocation `srun` behaves differently, submitting a request to the Slurm queue just like `sbatch` does.  Unlike `sbatch` though the launched process runs with its input and output attached to the terminal where it was launched, so using `srun` this way is not suitable for actual *batch* jobs. Also, `srun` is not affected by the SBATCH_EXPORT variable described above, so by default it *will* copy the current environment from where it is executed over to the process(es) it launches.  In general do not attempt to execute  batch files this way, as any included #SBATCH lines will have no effect.

## Checking the queue with squeue

To check if your job is running, use the command
```
squeue -j <job_list>
```

or

```
squeue -u $USER
```

You can provide a list of job IDs or user names, which is useful when there are many jobs running. The output will look more or less like this:

```
   JOBID      NAME     USER ST       TIME  NODES NODELIST(REASON)
61568899      wrap  apaw363 PD       0:00      1 (Resources)
61568901      wrap  apaw363 PD       0:00      1 (Resources)
61568970      wrap  apaw363 PD       0:00      1 (Resources)
```

The output shows the job state (column "ST") and various basic job specs, such as time spent running (column "TIME"), and the number of allocated nodes (column "NODES"). Additional job information can be provided, consult the *squeue* man page to find out more.

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

## How Slurm schedules jobs

Jobs in the Slurm queue have a priority which depends on several factors including size, age, owner, and the "partition" to which they belong. Each partition can be considered as an independent queue, with the slight complications that a job can be submitted to multiple partitions (though it will only *run* in one of them) and a compute node may belong to multiple partitions.

Slurm does not deliberately delay large jobs in favour of smaller low-priority jobs, but it does employ a backfill algorithm which searches the queue for jobs which are small enough that they can start and run to completion before the resources necessary to start any higher priority jobs are expected to become available. This increases overall utilization but changes the order of job starts from being strictly priority based to being a function of the workload and the job size.  With the backfill scheduler smaller jobs have a higher velocity through the queue than larger jobs, all other things being equal.

Job size is multi-dimensional, based on
 - Time: long or short and
 - Resource request: narrow (1 or a few cores) or broad (many cores).


## How to choose the right runtime environment (For NIWA users)

Kupe consists of different runtime environments. Here is some guidance for choosing the best environment for your requirements.

Symbols:

:heavy_check_mark: - best suited for this job type

:heavy_multiplication_x: - not suitable for this job type

no symbol - works but not ideal

#### Job Type

|                                                            | XC50 compute           | CS500 multi-purpose    | CS500 virtual lab | elogin node |
|------------------------------------------------------------|:----------------------:|:----------------------:|:-----------------:|:------------|
|Interactive work: building code                             |:heavy_multiplication_x:|                        |                   | :heavy_check_mark: |
|Interactive work: visualisation, editing, data discovery ...|:heavy_multiplication_x:|:heavy_multiplication_x:|:heavy_check_mark: |       |
|Non-interactive work: compute jobs, script-based pre- and post-processing|:heavy_check_mark:|:heavy_check_mark:|:heavy_multiplication_x:|:heavy_multiplication_x:|

#### Job Size: Cores

|                             | XC50 compute     | CS500 multi-purpose    | CS500 virtual lab      |
|-----------------------------|:----------------:|:----------------------:|:----------------------:|
| Small jobs on few cores     |                  |:heavy_check_mark:      |:heavy_check_mark:      |
| Medium jobs 10-40 cores     |:heavy_check_mark:|:heavy_check_mark:      |                        |
| Large jobs on > 40 cores    |:heavy_check_mark:|:heavy_multiplication_x:|:heavy_multiplication_x:|

#### Job Size: Memory

TBD

#### Job Size: Runtime

TBD

#### IO and CLI tools

|                                        | XC50 compute           | CS500 multi-purpose | CS500 virtual lab |
|----------------------------------------|:----------------------:|:-------------------:|:-----------------:|
| IO intensive jobs on few cores (e.g., EDA) |:heavy_multiplication_x:|:heavy_check_mark:   |:heavy_check_mark: |
| Scripted jobs that need many CLI tools |:heavy_multiplication_x:|:heavy_check_mark:   |:heavy_check_mark: |
