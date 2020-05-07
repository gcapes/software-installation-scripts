# Official instructions are here: https://en.wikibooks.org/wiki/SPM/Installation_on_64bit_Linux#Installation

# Standard installation - users should compile a standalone version on CSF.
# =========================================================================
VER=12.5
SPM_ROOT=/opt/apps/apps/binapps/matlab/third-party-toolboxes/spm
INSTALL_DIR=${SPM_ROOT}/${VER}
cd ${SPM_ROOT}
ZIP_FILE=${SPM_ROOT}/spm${VER}.zip
TEMP=${SPM_ROOT}/temp

if [ ! -f "${ZIP_FILE}" ]; then
  wget http://www.fil.ion.ucl.ac.uk/spm/download/restricted/eldorado/spm${VER}.zip
fi

if [ ! -d "${INSTALL_DIR}" ]; then
  unzip -q spm${VER}.zip -d ${TEMP}
  mv ${TEMP}/spm12 ${INSTALL_DIR}
  rmdir ${TEMP}
else
  echo "Installation directory already exists: ${INSTALL_DIR}"
  echo "Installation aborted"
fi
# So far this is the standard installation, i.e. not for compiled MATLAB.
# See compile.md for instructions on how to compile the toolbox.
