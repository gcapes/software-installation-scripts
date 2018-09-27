# Install FreeSurfer v6.0.0 on Ubuntu 16.04
# See http://surfer.nmr.mgh.harvard.edu/fswiki/DownloadAndInstall#FreeSurferDownloadandInstall
# Source this script with admin rights (sudo)

# Download installer
cd ~/Downloads
wget ftp://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/6.0.0/freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.0.tar.gz
tar -C /usr/local -xzvf freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.0.tar.gz

# Set up environment
export FREESURFER_HOME=/usr/local/freesurfer
source $FREESURFER_HOME/SetUpFreeSurfer.sh

# Install dependencies 
sudo apt-get install tcsh
sudo apt-get install libjpeg62
