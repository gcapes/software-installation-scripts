# Official instructions are here: https://en.wikibooks.org/wiki/SPM/Installation_on_64bit_Linux#Installation

# Standard installation - not suitable for CSF
# =================================================
# Start in home directory on CSF
wget http://www.fil.ion.ucl.ac.uk/spm/download/restricted/eldorado/spm12.zip
mkdir temp
unzip spm12.zip -d temp/ # Unzip to temporary location to avoid overwriting previous installation
export SPM12_ROOT=/opt/gridware/apps/binapps/matlab/third_party_toolboxes/spm/12-r6906
mkdir $SPM12_ROOT
cp -r temp/spm12/* $SPM12_ROOT
# So far this is the standard installation, i.e. not for compiled MATLAB.
# See compile.md for instructions on how to compile the toolbox.
