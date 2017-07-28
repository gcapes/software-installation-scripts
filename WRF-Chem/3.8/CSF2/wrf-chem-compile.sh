# This script should be sourced from the WRF-Chem installation directory
export WRF_CHEM_BASE=/opt/gridware/apps/intel-15.0/WRF-Chem/3.8/
cd $WRF_CHEM_BASE
wget http://www2.mmm.ucar.edu/wrf/src/WRFV3.8.TAR.gz
tar -xzf WRFV3.8.TAR.gz
wget http://www2.mmm.ucar.edu/wrf/src/WRFV3-Chem-3.8.TAR.gz
cd WRFV3
tar -xzf WRFV3-Chem-3.8.TAR.gz

module load compilers/intel/fortran/15.0.3
module load libs/intel-15.0/hdf/5/1.8.16
module load libs/intel-15.0/netcdf/4.4.0
module load libs/intel-15.0/zlib/1.2.8
module load mpi/intel-15.0/openmpi/1.8.3-ib

# WRF variables
export WRFIO_NCD_LARGE_FILE_SUPPORT=1
export JASPERLIB=/usr/lib64
export JASPERINC=/usr/include/jasper
# Use variables already set by module files
export MPI_ROOT=$MPI_HOME
export HDF5=$HDF5_PATH

# WRF-Chem variables
export WRF_CHEM=1
export WRF_KPP=1
echo "=================================================================="
echo "Now edit arch/Config_new.pl"
echo "Search for \$I_really_want_to_output_grib2_from_WRF = \"FALSE\""
echo "Then set it to \"TRUE\""
echo "=================================================================="
echo "Then run ./configure using options 15. (dmpar) INTEL (ifort/icc)"
echo " and 1. Basic nesting"
echo "=================================================================="

echo "=================================================================="
echo "After running configure, append flags to variables in configure.wrf"
echo "-------------------------------------------------------------------"
echo "In configure.wrf, append the flags: -msse2 -axSSE4.2,AVX,CORE-AVX2"
echo "to the following variables, so that WRF will run on any node:"
echo "	SFC"
echo "	SCC"
echo "	CCOMP"
echo "	CFLAGS_LOCAL"
echo "	FCOPTIM"
echo "=================================================================="
echo "Now compile WRF (before WPS)"
echo "----------------------------"
echo "./compile -j 1 em_real 2>&1 | tee -a compile-em_real-serial.log"
echo "=================================================================="
# Success looks like this:
# ==========================================================================
# build started:   Mon Jul 17 13:36:45 BST 2017
# build completed: Mon Jul 17 15:27:18 BST 2017
#  
# --->                  Executables successfully built                  <---
#  
# -rwxr-xr-x 1 mbexegc2 support 64777234 Jul 17 15:27 main/ndown.exe
# -rwxr-xr-x 1 mbexegc2 support 64577101 Jul 17 15:27 main/real.exe
# -rwxr-xr-x 1 mbexegc2 support 63537566 Jul 17 15:27 main/tc.exe
# -rwxr-xr-x 1 mbexegc2 support 76141671 Jul 17 15:25 main/wrf.exe
#  
# ==========================================================================
