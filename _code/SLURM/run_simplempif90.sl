#!/bin/bash -e

#SBATCH --partition=Debug
#SBATCH -A niwa99999
#SBATCH --job-name=simplempif90
#SBATCH --time=00:01:00
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
##SBATCH --mem-per-cpu=1G

#module load mpich/ge/gcc/64/3.2
echo "SLURM_NNODES = $SLURM_NNODES"
echo "SLURM_NTASKS = $SLURM_NTASKS"
srun ../Fortran/simpleMpi
