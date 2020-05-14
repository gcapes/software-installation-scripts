# Makefile to split up the MATLAB installer into chunks suitable for iso files for ESD.

# This requires you to have downloaded the installer files,
# and use the dirctory naming convention Downloads/MathWorks/RXXXX-OperatingSystem.
# You should also first put the network.lic file and the installer.sh or installer.bat file
# (to recombine the isos and run the MATLAB installer) in the top level directory.

VER=R2020a
MW=~/Downloads/MathWorks
# OS options are: (lin|mac|win)
OS=lin
INSTALLER_DIR=${MW}/${VER}-${OS}
ISO_DIR=${MW}/${VER}-${OS}-for-iso

ifneq (, $(findstring win, ${OS}))
    INSTALL_SCRIPT=${INSTALLER_DIR}/install.bat
else
    INSTALL_SCRIPT=${INSTALLER_DIR}/install.sh
endif

ISO1=${ISO_DIR}/iso1
ISO1_SUB=${ISO1}/${VER}
ISO2=${ISO_DIR}/iso2
ISO3=${ISO_DIR}/iso3
ISO_DIRS=${ISO1} ${ISO1_SUB} ${ISO2} ${ISO3}

BASE_FILENAME=${ISO_DIR}/MATLAB-${VER}-${OS}-
.PHONY: isos
isos: $(addsuffix .iso, $(addprefix ${BASE_FILENAME}, 1 2 3))

${BASE_FILENAME}%.iso: ${ISO_DIR}/iso%
	genisoimage -f -r -U -J -joliet-long -allow-lowercase -allow-multidot -o $@ $<

.PHONY: copy
copy: ${INSTALLER_DIR} ${ISO_DIRS} ${INSTALL_SCRIPT}
	rsync ${INSTALL_SCRIPT} ${ISO1}
	rsync -a ${INSTALLER_DIR}/ ${ISO1_SUB} --exclude archives
	rsync -a ${INSTALLER_DIR}/archives/common/examples ${ISO1_SUB}
	rsync -a ${INSTALLER_DIR}/archives/common ${ISO2} --exclude examples
	rsync -a ${INSTALLER_DIR}/archives ${ISO3} --exclude common

${INSTALL_SCRIPT}:
	@echo ================================================================================
	@echo $@ is missing! 
	@echo ================================================================================
	@false

.PHONY: dirs
dirs: ${ISO_DIRS}

${ISO_DIR}/iso%:
	mkdir -p $@

.PHONY: clean
clean:
	rm -rf ${ISO_DIR}
