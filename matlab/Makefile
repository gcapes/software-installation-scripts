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
    EXT=bat
else
    EXT=sh
endif

INSTALL_SCRIPT=./${VER}/${OS}/install.${EXT}
INSTALLER_INPUT=./${VER}/${OS}/installer_input.txt
LICENCE_FILE=./research-network.lic

ISO1=${ISO_DIR}/iso1
ISO1_SUB=${ISO1}/${VER}
ISO2=${ISO_DIR}/iso2
ISO3=${ISO_DIR}/iso3
ISO_DIRS=${ISO1} ${ISO1_SUB} ${ISO2} ${ISO3}

BASE_FILENAME=${ISO_DIR}/MATLAB-${VER}-${OS}-
.PHONY: isos
isos: $(addsuffix .iso, $(addprefix ${BASE_FILENAME}, 1 2 3))

${BASE_FILENAME}%.iso: ${ISO_DIR}/iso% copy
	genisoimage -f -r -U -J -joliet-long -allow-lowercase -allow-multidot -o $@ $<

.PHONY: copy
copy: ${INSTALLER_DIR} ${ISO_DIRS} ${INSTALL_SCRIPT} ${INSTALLER_INPUT} ${LICENCE_FILE}
	cp ${INSTALL_SCRIPT} ${ISO1}
	cp ${LICENCE_FILE} ${ISO1_SUB}/network.lic
	rsync -a ${INSTALLER_DIR}/ ${ISO1_SUB} --exclude /archives
	cp -f ${INSTALLER_INPUT} ${ISO1_SUB}
	rsync -a ${INSTALLER_DIR}/archives/common/examples ${ISO1}
	rsync -a ${INSTALLER_DIR}/archives/common ${ISO2} --exclude common/examples
	rsync -a ${INSTALLER_DIR}/archives ${ISO3} --exclude archives/common

.PHONY: dirs
dirs: ${ISO_DIRS}

${ISO_DIR}/iso%:
	mkdir -p $@

.PHONY: clean
clean:
	rm -rf ${ISO_DIR}
