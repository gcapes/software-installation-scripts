# Makefile to split up the MATLAB installer into chunks suitable for iso files for ESD.

# Prerequisites:
# Download the installer files, using the directory naming convention ~/Downloads/MathWorks/RXXXX-OperatingSystem.
# Update the installer.sh and installer.bat files in this repo for the current year's release.
# Prepare the installer_input.txt files with this year's FIK and release numbers.
# You should also download the Windows NAG toolbox installer to your downloads directory.

VER=R2021a
MW=~/Downloads/MathWorks
# OS options are: (lin|mac|win)
OS=lin
INSTALLER_DIR=${MW}/${VER}-${OS}
ISO_DIR=${MW}/${VER}-${OS}-for-iso
MAKEFILE_DIR_WITH_SLASH=$(dir $(realpath $(firstword $(MAKEFILE_LIST))))
MAKEFILE_DIR=$(patsubst %/,%,${MAKEFILE_DIR_WITH_SLASH})

ifneq (, $(findstring win, ${OS}))
    EXT=bat
    NAG=~/Downloads/mbw6i25ddl_setup.exe
else
    EXT=sh
endif

INSTALL_SCRIPT=${MAKEFILE_DIR}/${VER}/${OS}/install.${EXT}
INSTALLER_INPUT=${MAKEFILE_DIR}/${VER}/${OS}/installer_input.txt
LICENCE_FILE=${MAKEFILE_DIR}/research-network.lic

ISO1=${ISO_DIR}/iso1
ISO1_SUB=${ISO1}/${VER}
ISO2=${ISO_DIR}/iso2
ISO3=${ISO_DIR}/iso3

BASE_FILENAME=${ISO_DIR}/MATLAB-${VER}-${OS}-
.PHONY: isos
isos: $(addsuffix .iso, $(addprefix ${BASE_FILENAME}, 1 2 3))

${BASE_FILENAME}%.iso: ${ISO_DIR}/iso%
	genisoimage -f -r -U -J -joliet-long -allow-lowercase -allow-multidot -o $@ $<

.PHONY: dirs
dirs: ${ISO1} ${ISO1_SUB} ${ISO2} ${ISO3}

${ISO_DIR}/iso1: ${INSTALLER_DIR} ${INSTALL_SCRIPT} ${INSTALLER_INPUT} ${LICENCE_FILE}
	mkdir -p ${ISO1_SUB}
	cp ${INSTALL_SCRIPT} ${ISO1}
	cp ${LICENCE_FILE} ${ISO1_SUB}/network.lic
	rsync -a ${INSTALLER_DIR}/ ${ISO1_SUB} --exclude /archives
	cp -f ${INSTALLER_INPUT} ${ISO1_SUB}
	rsync -a ${INSTALLER_DIR}/archives/common/examples ${ISO1}
    ifdef NAG
	cp ${NAG} ${ISO1}
    endif

${ISO_DIR}/iso2: ${INSTALLER_DIR}
	rsync -a ${INSTALLER_DIR}/archives/common ${ISO2} --exclude common/examples

${ISO_DIR}/iso3: ${INSTALLER_DIR}
	rsync -a ${INSTALLER_DIR}/archives ${ISO3} --exclude archives/common

.PHONY: clean
clean:
	rm -rf ${ISO_DIR}
