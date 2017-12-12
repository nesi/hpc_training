#!/bin/bash -e
#SBATCH -J simple.R
#SBATCH --time=01:00     # Walltime
#SBATCH --mem=512  # memory/node (in MB)

# example usage:
# sbatch run_simple.sl

# load in the R module
module load cray-R

srun Rscript ../R/simple.R
