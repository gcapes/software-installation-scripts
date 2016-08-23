# WRF-Chem Build
# ==============

# For users, we need modulefiles for the zlib, hdf5 and netcdf builds.
# In the meantime, this is what we need (having run wrf-chem-libs-env.sh):

# WRF requires ZLIB_PATH
export ZLIB_PATH=$ZROOT
export PATH=$ZROOT/bin:$PATH
export INCLUDE=$ZROOT/include:$INCLUDE
export LD_LIBRARY_PATH=$ZROOT/lib:$LD_LIBRARY_PATH

# WRF requires HDF5_PATH
export HDF5_PATH=$HROOT
export PATH=$HROOT/bin:$PATH
export INCLUDE=$HROOT/include:$INCLUDE
export LD_LIBRARY_PATH=$HROOT/lib:$LD_LIBRARY_PATH

# WRF requires NETCDF
export NETCDF=$NROOT
export PATH=$NROOT/bin:$PATH
export INCLUDE=$NROOT/include:$INCLUDE
export LD_LIBRARY_PATH=$NROOT/lib:$LD_LIBRARY_PATH

# These are needed by WRF compilation scripts too (do this on CSF too!)
export JASPERLIB=/usr/lib64
export JASPERINC=/usr/include/jasper
export WRFIO_NCD_LARGE_FILE_SUPPORT=1
export NETCDF4=1
export FLEX_LIB_DIR=$FLEXROOT/lib
export WRF_KPP=1
export WRF_CHEM=1
export ENVCOMPDEFS="-DWRF_CHEM -DBUILD_CHEM=1 -DWRF_KPP"

# WRF requires MPI_ROOT
# OpenMPI module was loaded during libs set up
export MPI_ROOT=$MPI_HOME

# Set root directory of installation 
export WROOT=~/scratch/wrfchem-3.4.1/apps/WRF/3.4.1-VBS/WRFV3

