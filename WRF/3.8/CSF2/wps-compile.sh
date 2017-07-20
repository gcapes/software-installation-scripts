# Start in top-level WRF directory (one above WRFV3)
# Then source this file
wget http://www2.mmm.ucar.edu/wrf/src/WPSV3.8.TAR.gz
tar -xvf WPSV3.8.TAR.gz
cd WPS
echo "-----------------------------------------------------------"
echo "Configure will now run"
echo "Choose option 19.  Linux x86_64, Intel compiler    (dmpar)"
echo "-----------------------------------------------------------"
./configure
# The instructions recommend doing a serial compilation
# http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compilation_tutorial.php
# But previous builds (George) used dmpar option here.
# Someone might want to create large domains, so parallel might be useful. 
# 19.  Linux x86_64, Intel compiler    (dmpar)

./compile 2>&1 | tee -a compile-wps.log
# Looking for the following in the top level directory:
	# geogrid.exe
	# ungrib.exe
	# metgrid.exe
# Return to Build_WRF directory (i.e. top level folder - WRF/3.8)
cd ..
# Download geography data
wget http://www2.mmm.ucar.edu/wrf/src/wps_files/geog_complete.tar.bz2
mkdir WPS_GEOG
tar -xjf geog_complete.tar.bz2 -C WPS_GEOG
