#!/bin/bash
#SBATCH -J Deep_Conv_MPI_test 
#SBATCH --ntasks=64
#SBATCH --clusters=cm4
#SBATCH --partition=cm4_tiny
#SBATCH --mem=12000mb
#SBATCH --export=NONE #mightn't be necessary; might even cause issues if not set to ALL
#SBATCH -t 0-0:20:00 
#SBATCH -o slurm-mem-%j.out
#SBATCH -e slurm-mem-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rowan.brown@lmu.de

##export MPI_INC_DIR=/dss/dsshome1/lrz/sys/spack/release/22.2.1/opt/x86_64/intel-mpi/2019.12.320-gcc-wx7cjlg/compilers_and_libraries_2020.4.320/linux/mpi/intel64/include

module purge

module load slurm_setup
###module load python/3.8.11-base
###source ~/.conda_init ##from https://doku.lrz.de/faq-conda-and-python-virtual-environment-on-lrz-hpc-clusters-41616204.html

#module load admin/2.0 tempdir/1.0 lrz/1.0 spack/22.2.1  intel-oneapi-compilers/2022.2.0   intel-mkl/2020   intel-mpi/2019-intel 
#module load spack gcc intel intel-mpi intel-mkl intel-toolkit
# Dealing with environment modules
module load spack/22.2.1  intel-oneapi-compilers/2022.2.0   intel-mkl/2020   intel-mpi/2019-intel #pre-cm4

#module load intel-oneapi-vtune/2021.7.1
#export MPS_STAT_LEVEL=4

#./run/mitgcmuv
mpiexec -n $SLURM_NTASKS ./mitgcmuv
#mpiexec -n $SLURM_NTASKS aps --result-dir=./vtune ./run/mitgcmuv

#aps-report -x --format=html ./vtune

##module load StdEnv/2020 gcc/9.3.0
##module load gdal/3.5.1
##module load python/3.10

##source /home/rowan/snakes2/bin/activate
##python /dss/dsshome1/0B/ra85duq/test_script.py
##home/rowan/projects/rrg-pmyers-ad/rowan/NEMO-analysis-Graham/MLE.py
##ARGO/mixedlayer_UCSD/Argo_mixedlayers_all.py  
##python -m memory_profiler /home/rowan/projects/rrg-pmyers-ad/rowan/NEMO-analysis-Graham/EKE.py

