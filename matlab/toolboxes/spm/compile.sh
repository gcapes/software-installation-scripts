#!/bin/bash --login
#$ -cwd
#$ -N compile	# Give the job a name
#$ -m bea	# Email on start, end or abort
#$ -M firstname.surname@manchester.ac.uk

module load apps/binapps/matlab/R2019a

VER=12.4
SCRATCH=/scratch/${USER}
EXE_DIR=${SCRATCH}/SPM${VER}-standalone
SPM_TOOLBOX=${SCRATCH}/SPM${VER}

mkdir -p ${EXE_DIR}
matlab -batch "addpath ${SPM_TOOLBOX}; spm_jobman initcfg; spm_make_standalone('${EXE_DIR}');"
