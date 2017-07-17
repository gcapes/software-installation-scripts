# This script should be sourced from the WRF installation directory
export WRF_BUILD=/opt/gridware/apps/intel-15.0/WRF/3.8/ARW
wget http://www2.mmm.ucar.edu/wrf/src/WRFV3.8.TAR.gz
tar -xzf WRFV3.8.TAR.gz
cd WRFV3

module load compilers/intel/fortran/15.0.3
module load libs/intel-15.0/hdf/5/1.8.16
module load libs/intel-15.0/netcdf/4.4.0
module load libs/intel-15.0/zlib/1.2.8
module load mpi/intel-15.0/openmpi/1.8.3-ib

export WRFIO_NCD_LARGE_FILE_SUPPORT=1
export JASPERLIB=/usr/lib64
export JASPERINC=/usr/include/jasper
export MPI_ROOT=/opt/gridware/mpi/intel/openmpi/1.8.3--intel-15.0.3

echo "Now configure using options 15. (dmpar) INTEL (ifort/icc)"
echo " and 1. Basic nesting"
./configure
# 15. (dmpar) INTEL (ifort/icc)
# 1. Basic nesting

echo "Now append flags to variables in configure.wrf"
echo "View configure-wrf.sh for details"
# In configure.wrf, append the flags: -msse2 -axSSE4.2,AVX,CORE-AVX2
# to the following variables, so that WRF will run on any node:
	# SFC
	# SCC
	# CCOMP
	# CFLAGS_LOCAL
	# FCOPTIM
echo "Compile WRF before WPS"
echo "./compile -j 1 em_real 2>&1 | tee -a compile-em_real-serial.log"
