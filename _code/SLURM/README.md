---
layout: post
title: SLURM examples
permalink: /code/slurm-examples/
chapter: code-samples
---

# How to submit, monitor and cancel Slurm jobs


 1. Add ```module load slurm``` to your ```~/.bashrc``` file

 2. Compile ```../Fortran/simpleMpiF90```, see ```../Fortran/README.md```.

 3. Submit the jobs using the ```sbatch``` command. Note that ```run_array-analysis.sl``` takes a file argument, e.g. ```../../data/inflammation-01.csv```.

 4. Monitor the jobs with the ```squeue``` command.

 5. If desired, cancel the jobs with ```scancel```
