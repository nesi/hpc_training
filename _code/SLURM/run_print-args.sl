#!/bin/bash -e
#SBATCH -J print-args.R
#SBATCH --time=5:00     # Walltime
#SBATCH --mem=512  # memory/node (in MB)

# example usage:
# sbatch run_print-args.sl first second third

# load in the R module
module load cray-R

srun Rscript ../R/print-args.R $@ 
