#!/bin/bash
#SBATCH --account=nwg_so-clim.nwg_so-clim 	##needs to be set according to what accounts you're allowed to use
#SBATCH -J 0c_init			##job name
#SBATCH --qos=12h			##needs to be set explicitly; controls queuing
#SBATCH -t 0-12:00			##job time limit
#SBATCH -n 4				##number of MPI tasks (I assume all on the same node...)
#SBATCH -o slurm-mem-%j.out		##output file
#SBATCH -e slurm-mem-%j.err		##error file
#SBATCH --mail-type=ALL			##email me all types of messages
#SBATCH --mail-user=rowan.brown@awi.de	##my email
#SBATCH --mem=12000mb 			##memory per node	
###SBATCH --export=NONE 			##export variables from the submission environment to the launched app

##stuff copied directly from Martin via: https://spaces.awi.de/display/MIT/MITgcm+on+Albedo
##not 100% certain what everything does... might relate to communication between diff nodes (if you're using multiple)
# list of hosts that you are running on
hostlist=$(scontrol show hostnames | tr '\n' ',' | rev | cut -c 2- | rev)
echo "hosts: $hostlist" 
# make new files created in this job readable for everybody
umask 022
#
# load your modules with "module load ..."
module load intel-oneapi-compilers/
module load intel-oneapi-mpi/
#module load netcdf-fortran/4.5.4-oneapi2022.1.0
# maximum possible stacksize
ulimit -s unlimited
# even though we do not run an OpenMP code it is still a good idea to always set this
export OMP_NUM_THREADS=1
# srun ./mitgcmuv
# Sometimes it may be important to bind MPI processes (ranks) to individual cores on the node
srun --cpu_bind=cores /albedo/home/robrow001/MITgcm/verification/tutorial_deep_convection_cp/run/mitgcmuv
#mpiexec -n $SLURM_NTASKS /albedo/home/robrow001/MITgcm/verification/tutorial_deep_convection_cp/run/mitgcmuv
