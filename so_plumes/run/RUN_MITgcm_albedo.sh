#!/bin/bash
#SBATCH --account=nwg_so-clim.nwg_so-clim
#SBATCH -J Conv_test 
#SBATCH --qos=30min
#SBATCH -t 0-00:29 
#SBATCH -n 1 
#SBATCH -o slurm-mem-%j.out 
#SBATCH -e slurm-mem-%j.err 
#SBATCH --mail-type=ALL 
#SBATCH --mail-user=rowan.brown@awi.de 
#SBATCH --mem=1000mb

module load intel-oneapi-compilers/
module load intel-oneapi-mpi/

###module load slurm_setup
###module load python/3.8.11-base
###source ~/.conda_init ##from https://doku.lrz.de/faq-conda-and-python-virtual-environment-on-lrz-hpc-clusters-41616204.html
###module load spack/22.2.1   intel-oneapi-compilers/2021.4.0   intel-mkl/2020   intel-mpi/2019-intel  
#mpiexec -n $SLURM_NTASKS ./run/mitgcmuv
./mitgcmuv
##module load StdEnv/2020 gcc/9.3.0
##module load gdal/3.5.1
##module load python/3.10
##source /home/rowan/snakes2/bin/activate
##python /dss/dsshome1/0B/ra85duq/test_script.py
##home/rowan/projects/rrg-pmyers-ad/rowan/NEMO-analysis-Graham/MLE.py
##ARGO/mixedlayer_UCSD/Argo_mixedlayers_all.py  
##python -m memory_profiler /home/rowan/projects/rrg-pmyers-ad/rowan/NEMO-analysis-Graham/EKE.py
