#!/bin/bash
##^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^##
##            (May07, 2021: weissgib@ualberta.ca)                     ##
##          Copied 27 Feb 2023 by rowan2@ualberta.ca                  ##
##     Copied again onto an LRZ sytem on September 12 2024            ##
## 	And again onto Albedo on November 19 2024		      ##  
##^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^##
#SBATCH --account=robrow001
#SBATCH -J Serial_conv_test 
#SBATCH --ntasks=1 
#SBATCH -D ./
######SBATCH --get-user-env
######SBATCH --clusters=cm2
######SBATCH --partition=smp#########cm2_std
######SBATCH --qos=cm2_std
#SBATCH --mem=12000mb
#SBATCH --export=NONE
#SBATCH -t 0-8:00 
#SBATCH -o slurm-mem-%j.out
#SBATCH -e slurm-mem-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rowan.brown@awi.de

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

