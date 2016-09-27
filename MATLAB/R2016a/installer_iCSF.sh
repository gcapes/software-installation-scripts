# Copy installation files onto iCSF (e.g. home directory)
# Then run this script (./installer_iCSF.sh)

# Note that MATLAB's installer_input.txt file for R2016a doesn't work in the same way as
# previous version of MATLAB. It should set the path to the licence file, but it fails
# to do this. You therefore have to manually activate (i.e. point it to the network.lic
# file post-installation).

./install -inputFile installer_input_iCSF.txt

# To get the files from the iso to iCSF, you must first mount the iso on your PC
# then copy the files over (after compressing to tar.gz)
# This leaves the directories as read-only, so copying to one of them will fail.
# So change ownership retrospectively:
cd /opt/gridware/apps/binapps/matlab/R2016a
chmod -R u+w .

# Navigate back to directory containing installer script
cd -

# Copy files to fix a bug in the installation script.
cp libmwservices.so /opt/gridware/apps/binapps/matlab/R2016a/bin/glnxa64/libmwservices.so
cp libmwservices.xml /opt/gridware/apps/binapps/matlab/R2016a/bin/registry/libmwservices.xml
