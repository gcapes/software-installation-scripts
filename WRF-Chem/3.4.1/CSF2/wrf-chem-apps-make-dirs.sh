# WRF-Chem Build
# ==============

# For users, we need modulefiles for the zlib, hdf5 and netcdf builds.
# In the meantime, this is what we need (having run wrf-chem-libs-env.sh):

# Set environment variables required by WRF
. wrf-chem-apps-env.sh

# Now our usual variabless for convenient directory naming
export WVER=3.4.1
mkdir -p $APPS/WRF/$WVER
cd $APPS/WRF/$WVER

# The build and install dir are the same (no 'install' target in Makefile)
mkdir -p archive/ARW archive/WPS

# Put downloads in archive dirs
cp $WRF_FILE archive/ARW
cp $WPS_FILE archive/WPS
cp $WPS_GEOG archive/WPS
cp $WPS_GEOG_UPDATE archive/WPS

tar xzf archive/ARW/wrfchem-3.4.1-mosaic-h2no5het.tar.gz
export WROOT=$APPS/WRF/$WVER/mosaic_n2o5het_v3.4.1
cd WROOT
