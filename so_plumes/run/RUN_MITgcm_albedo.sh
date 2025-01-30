#!/bin/bash
#SBATCH --account=nwg_so-clim.nwg_so-clim
#SBATCH -J 2-Layer_fluid 
#SBATCH --qos=12h
#SBATCH -t 0-12:00 
#SBATCH -n 4
#SBATCH -o slurm-mem-%j.out 
#SBATCH -e slurm-mem-%j.err 
#SBATCH --mail-type=ALL 
#SBATCH --mail-user=rowan.brown@awi.de 
#SBATCH --mem=12000mb

#stuff copied directly from Martin via: https://spaces.awi.de/display/MIT/MITgcm+on+Albedo
#not 100% certain what everything does... might relate to communication between diff nodes (if you're using multiple)

# get and print (ie echo) list of hosts (in nice readable format) that you are running on
hostlist=$(scontrol show hostnames | tr '\n' ',' | rev | cut -c 2- | rev)
echo "hosts: $hostlist" 

# make new files created in this job readable for everybody
umask 022

module load intel-oneapi-compilers/
module load intel-oneapi-mpi/

# maximum possible stacksize (stacksize is a part of the memory that manages function calls, local variables, and control flow; in a recursive heavy program you can run out of stack memory, leading to a stack overflow or segmentation error)
ulimit -s unlimited

# even though we do not run an OpenMP code it is still a good idea to always set this
export OMP_NUM_THREADS=1

# Sometimes it may be important to bind MPI processes (ranks) to individual cores on the node
srun --cpu_bind=cores /albedo/home/robrow001/MITgcm/so_plumes/run/mitgcmuv

###module load slurm_setup
###module load python/3.8.11-base
###source ~/.conda_init ##from https://doku.lrz.de/faq-conda-and-python-virtual-environment-on-lrz-hpc-clusters-41616204.html
###module load spack/22.2.1   intel-oneapi-compilers/2021.4.0   intel-mkl/2020   intel-mpi/2019-intel  
#mpiexec -n $SLURM_NTASKS ./run/mitgcmuv
##/albedo/home/robrow001/MITgcm/so_plumes/run/mitgcmuv
##module load StdEnv/2020 gcc/9.3.0
##module load gdal/3.5.1
##module load python/3.10
##source /home/rowan/snakes2/bin/activate
##python /dss/dsshome1/0B/ra85duq/test_script.py
##home/rowan/projects/rrg-pmyers-ad/rowan/NEMO-analysis-Graham/MLE.py
##ARGO/mixedlayer_UCSD/Argo_mixedlayers_all.py  
##python -m memory_profiler /home/rowan/projects/rrg-pmyers-ad/rowan/NEMO-analysis-Graham/EKE.py
