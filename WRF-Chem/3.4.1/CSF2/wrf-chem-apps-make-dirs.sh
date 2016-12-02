# WRF-Chem Build
# ==============

# For users, we need modulefiles for the zlib, hdf5 and netcdf builds.
# In the meantime, this is what we need (having run wrf-chem-libs-env.sh):

# Set environment variables required by WRF
. wrf-chem-apps-env.sh

# Now our usual variables for convenient directory naming
mkdir -p $WROOT
export WPARENT=$APPS/WRF-Chem/$WVER
cd $WPARENT

# The build and install dir are the same (no 'install' target in Makefile)
mkdir -p archive/ARW # archive/WPS (not using WPS - geog data from Doug Lowe)

# Put downloads in archive dirs (if using downloads)
#cp $WRF_FILE archive/ARW
#cp $WPS_FILE archive/WPS
#cp $WPS_GEOG archive/WPS
#cp $WPS_GEOG_UPDATE archive/WPS

# If using modified code (WRFV3 folder from SVN repository)
echo "Now put the WRF chem code into the following directories:"
echo $WROOT
echo $WPARENT/archive/ARW

cd $WROOT
svn checkout http://wyrcean.seaes.manchester.ac.uk/svn/atmos_modelling/dynamic_modelling/WRF-CHEM/branches/VBS_water_n2o5het_bburn_v3.4.1 .
