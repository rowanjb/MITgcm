#!/bin/bash
#SBATCH -J Deep_Conv_MPI_test 
#SBATCH --ntasks=1##4
####################SBATCH --ntasks-per-node=4
#SBATCH --clusters=serial
#SBATCH --partition=serial_std
#SBATCH --mem=4000mb
#SBATCH --export=NONE #mightn't be necessary; might even cause issues if not set to ALL
#SBATCH -t 0-0:30:00 
#SBATCH -o slurm-mem-%j.out
#SBATCH -e slurm-mem-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rowan.brown@lmu.de

# get and print (ie echo) list of hosts (in nice readable format) that you are running on
hostlist=$(scontrol show hostnames | tr '\n' ',' | rev | cut -c 2- | rev)
echo "hosts: $hostlist"

# make new files created in this job readable for everybody
umask 022

module purge
module load slurm_setup
#module load admin/2.0 tempdir/1.0 lrz/1.0 spack/22.2.1  intel-oneapi-compilers/2022.2.0   intel-mkl/2020   intel-mpi/2019-intel 
#module load spack gcc intel intel-mpi intel-mkl intel-toolkit
module load spack/22.2.1  intel-oneapi-compilers/2022.2.0   intel-mkl/2020   intel-mpi/2019-intel #pre-cm4

# maximum possible stacksize (stacksize is a part of the memory that manages function calls, local variables, and control flow; in a recursive heavy program you can run out of stack memory, leading to a stack overflow or segmentation error)
ulimit -s unlimited

# even though we do not run an OpenMP code it is still a good idea to always set this
export OMP_NUM_THREADS=1

module load intel-oneapi-vtune/2021.7.1
export MPS_STAT_LEVEL=4

./mitgcmuv
#mpiexec -n $SLURM_NTASKS ./mitgcmuv
#mpiexec -n $SLURM_NTASKS aps --result-dir=./vtune ./mitgcmuv

# srun ./mitgcmuv
# Sometimes it may be important to bind MPI processes (ranks) to individual cores on the node
#srun --cpu_bind=cores ./mitgcmuv

aps-report -x --format=html ./vtune
