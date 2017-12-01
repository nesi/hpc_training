---
layout: post
title: HPC3 Slurm job scheduler
---

You will learn how to submit jobs using the Slurm scheduler.

## What is Slurm?

Slurm is a software used on the NeSI supercomputers for scheduling and managing job submission requests. A job is a script that tells the scheduler how much resources you will require to perform a given computational work. Slurm will then try to accommodate your request while maximising overall user experience.

SLURM was an acronym for Simple Linux Utility for Resource Management

Additional information can be found at: 
 - https://slurm.schedmd.com/archive/slurm-17.02.9/
 - https://support.nesi.org.nz/hc/en-gb/articles/115000194910-Submitting-Slurm-Jobs-on-Pan

Adapted from Jordi Blasco's [Introduction to Slurm documentation](https://wiki.auckland.ac.nz/download/attachments/63145549/introduction-slurm.pdf?api=v2)

## How Slurm works

Jobs in the Slurm queue have a priority which depends on several factors including size, age, owner, and the "partition" to which they belong. Each partition can be considered as an independent queue, with the slight complications that a job can be submitted to multiple partitions (though it will only *run* in one of them) and a compute node may belong to multiple partitions.

Slurm does not deliberately delay large jobs in favor of smaller low-priority jobs, but it does employ a backfill algorithm which searches the queue for jobs which are small enough that they can start and run to completion before the resources necessary to start any higher priority jobs are expected to become available. This increases overall utilization but changes the order of job starts from being strictly priority based to being a function of the workload and the job size.  With the backfill scheduler smaller jobs have a higher velocity through the queue than larger jobs, all other things being equal.

Job size is multi-dimensional, based on
 - Time: long or short and
 - Resource request: narrow (1 or a few cores) or broad (many cores).

## Getting started

To use the Slurm scheduler on Kupe, you will first need to load the `slurm` module:
```
module load slurm
```
You could add this line to your `.profile` if you don't want to load the module on every login, though we do plan to remove the need to do this step at all.

## Submitting a job

Slurm works like any other scheduler - you can submit jobs to the queue, and Slurm will run them for you when the resources that you requested become available. Jobs are usually defined using a job script, although you can also submit jobs without a script, directly from the command line:

```
sbatch -A <project_code> -t 10 --wrap "echo hello world"
sbatch --account <project_code> --time 10 --wrap "echo hello world"
```
These two variants of the command are equivalent - Slurm offers short and long versions of many options (although there is no short form of `--wrap`. The option `-t` or `--time` sets a limit on the total run time of the job allocation. Note that each partition on which the jobs are run has its own time limit. If the set time limit exceeds the limit for the partition, the job will become "PENDING" (for more information on job statuses, see below). The `--wrap` option means that the following string (in "") will be turned into a simple shell script by Slurm.

You should now find an output file named `slurm-<job ID>.out` that contains stdout captured by Slurm, so it should have the phrase `hello world` in it.

Here is another simple example. Build the Fortran MPI program in the `code/Fortran` directory first, if you haven't done so already:
```
ftn -o simpleMpi simpleMpi.f90
```
Then change to the `code/SLURM` directory and have a look at the file `run_simplempif90.sl`:
```
cat run_simplempif90.sl
```
Let's have a look at the directives:
```
#SBATCH --job-name=simplempif90
#SBATCH --time=00:01:00
```
These two set a job name (for your reference) and the wallclock time, as in our previous example.
```
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
```
The job will be run on a single node and with 4 MPI tasks. Each MPI task will run only on one thread.
```
#SBATCH --mem-per-cpu=1G
```
Each task may use up to 1GB of memory, otherwise it will be cancelled.

**Important note:** Unlike LoadLeveler, Slurm expects directives to come first in a submission script - don't insert any commands above the directives block.

The program is then launched using the `srun` command:
```
srun ../Fortran/simpleMpi
```
This command will create the MPI runtime environment need to run the parallel program.

**Important note:** For OpenMP jobs you will need to set --cpus-per-task to a value larger than 1 and explicitly set the
OMP_NUM_THREADS variable. By default the layout of threads will be two per physical core, meaning hyperthreading is enabled. To turn hyperthreading off you can use --hint=nomultithread. For example:
```
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --hint=nomultithread
export OMP_NUM_THREADS=8
srun <my_app>
```

Submit the job using
```
sbatch run_simplempif90.sl
```
Output from `stdout` and `stderr` will be once again written into files `slurm-<job number>.out` and `slurm-<job number>.err`.

To check if your job is running, use the command
```
squeue -j <job_list> -u <user_list>
squeue --jobs=<job_list> --user=<user_list>
```
You can provide a list of job IDs and user names, which is useful when there are many jobs running. The output will look more or less like this:

```
   JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
61568899 merit_sho     wrap  apaw363 PD       0:00      1 (Resources)
61568901 merit_sho     wrap  apaw363 PD       0:00      1 (Resources)
61568970 merit_sho     wrap  apaw363 PD       0:00      1 (Resources)
```

The output shows the job state (column "ST") and various basic job specs, such as time spent running (column "TIME"), and the number of allocated nodes (column "NODES"). Additional job information can be provided, consult the `squeue` man page to find out more.

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

Another useful Slurm command is `sacct` which retrieves information about completed jobs. For example:

```
sacct -j 61568970
```

Will show us something like:

```
        JobName        JobID      User               Start    Elapsed     AveCPU     MinCPU   TotalCPU  AllocCPUS      State     ReqMem     MaxRSS                       NodeList
--------------- ------------ --------- ------------------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ------------------------------
           wrap     61568970   apaw363 2017-09-22T08:05:28   00:00:00                        00:00.071          1  COMPLETED        1Gc                       compute-physics-001
          batch 61568970.ba+           2017-09-22T08:05:28   00:00:00   00:00:00   00:00:00  00:00.071          1  COMPLETED        1Gc      1760K            compute-physics-001
```

The "MaxRSS" column reports the memory used during the job and is useful when trying to determine a sensible amount of memory to request in the submission script.

### List of Slurm Commands

Here is a list of the most commonly used Slurm commands:

- *sbatch* - submits a script job
- *scancel* - cancels a running or pending job
- *srun* - runs a command across nodes
- *squeue* - lists the job queue (ie: Pending) and running jobs.
- *sacct* - lists job accounting information for running and completed jobs.

### Commonly used Slurm environment variables

These environment variables can be used in Slurm submission scripts:

- $SLURM_JOBID (job id)
- $SLURM_NNODES (number of nodes)
- $SLURM_SUBMIT_DIR (directory job was submitted from)
- $SLURM_ARRAY_JOB_ID (job id for the array)
- $SLURM_ARRAY_TASK_ID (job array index value)

### More job examples

Here are a few more examples for submitting jobs with Slurm.

#### run_simple.sl

This script runs the R script simple.R. Find the output in the slurm output file.

```
sbatch -A <project_code> run_simple.sl
```

#### run_print-args.sl

This script demonstrates how to pass command line arguments from the Slurm job down to an R script. Find the output in the slurm output file.

```
sbatch -A <project_code> run_print-args.sl first second third
```

#### run_array-analysis

Example of a job array. This script demonstrates how to run an analysis on different input datasets in parallel. Note that it is highly recommended to use the [Cylc workflow engine](https://cylc.github.io/cylc) if you need to run a job with complex task dependencies.

```
sbatch -A <project_code> run_array-analysis.sl
sbatch --array=1 -A <project_code> run_array-analysis.sl something.txt
sbatch --array=1-2 -A <project_code> run_array-analysis.sl
```

### How to choose the right runtime environment

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
