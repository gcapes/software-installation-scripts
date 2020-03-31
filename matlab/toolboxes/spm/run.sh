#!/bin/bash --login
#$ -cwd
#$ -N spm-run	# Give the job a name
#$ -m bea	# Email on start, end or abort
#$ -M firstname.surname@manchester.ac.uk

module load apps/binapps/matlab/R2019a

VER=12.4
EXE_DIR=/scratch/${USER}/SPM${VER}-standalone
USER_SCRIPT=/absolute/path/to/yourscript.m
cd ${EXE_DIR}
./run_spm12.sh ${MATLAB_HOME} script ${USER_SCRIPT}
