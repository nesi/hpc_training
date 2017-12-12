#!/bin/bash -e
#SBATCH -J array-analysis.R
#SBATCH --time=5:00     # Walltime
#SBATCH --mem=512  # memory/node (in MB)
#SBATCH --array=1-5 # size of the array

# example usage:
# sbatch --array=1-5 run_array-analysis.sl

# Variable that holds the array id value
# $SLURM_ARRAY_TASK_ID

# Convert array id to have leading 0 padding to conform
# with data filename convention e.g. 1 -> 01, 11 -> 11
file_num=$(printf '%.2d' $SLURM_ARRAY_TASK_ID)

# load in the R module
module load cray-R

srun Rscript ../R/array-analysis.R ../../data/inflammation-${file_num}.csv 
