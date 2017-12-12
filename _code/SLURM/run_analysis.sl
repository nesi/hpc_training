#!/bin/bash -e
#SBATCH -J array-analysis.R
#SBATCH --time=5:00     # Walltime
#SBATCH --mem=512  # memory/node (in MB)

# example usage:
# sbatch run_array-analysis.sl ../../data/inflammation-01.csv

# load in the R module
module load cray-R

#$1 is the path to the csv file
srun Rscript ../R/array-analysis.R $1 
