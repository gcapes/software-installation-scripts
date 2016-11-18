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

# Now our usual vars for convenient directory naming
export WVER=3.4.1-VBS-16Nov2016

# WRF source files
# export WRF_FILE=/scratch/mbexegc2/WRF_rpt/apps/WRF/3.7.1/archive/ARW/WRFV3.7.1.TAR.gz
export WRF_FILE=$HOME/wrfchem-3.4.1-mosaic-h2no5het.tar.gz # Replaces file above
export WPS_FILE=$HOME/WPSV3.4.1.TAR.gz
# Data from 3.4.1 not available for download any more so use newer data
# I actually used geography data sent by Doug Lowe instead of running WPS.
export WPS_GEOG=/scratch/mbexegc2/WRF_rpt/apps/WRF/3.7.1/archive/WPS/geog_complete.tar.bz2
export WPS_GEOG_UPDATE=/scratch/mbexegc2/WRF_rpt/apps/WRF/3.7.1/archive/WPS/geog_new3.7.tar.bz2
export NCL_FILE=/scratch/mbexegc2/ncl_ncarg-6.3.0.Linux_RHEL6.4_x86_64_nodap_gcc447.tar.gz


#export WROOT=$APPS/WRF/$WVER/mosaic_n2o5het_v3.4.1
export WROOT=$APPS/WRF/$WVER/WRFV3

