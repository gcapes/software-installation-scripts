VER=2.4.5157
ZIP_FILE=spinach_${VER}.zip
TB_DIR=/opt/apps/apps/binapps/matlab/third-party-toolboxes/spinach 
INSTALL_DIR=${TB_DIR}/${VER}
if [ ! -f "${ZIP_FILE}" ]; then
  wget http://spindynamics.org/documents/${ZIP_FILE}
fi

if [ ! -d "${INSTALL_DIR}" ]; then
  unzip -q ${ZIP_FILE} -d ${TB_DIR}
  mv ${TB_DIR}/spinach_${VER} ${INSTALL_DIR}
else
  echo "Installation directory already exists: ${INSTALL_DIR}"
  echo "Installation aborted"
fi

