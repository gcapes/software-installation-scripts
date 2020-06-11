# Download and install mtex toolbox for MATLAB.
# On CSF3 this wasn't smooth because MTEX needs glibc >= 2.22, which is newer than
# what we have on CSF3.
# So we have to build the binaries again using the existing glibc.
#
# This makefile will download installers to the current directory,
# and create some extra files and directories, so it's best to create a new
# temporary directory before running this makefile.

MTEX_VER=5.3.1
NFFT_VER=3.5.1
MTEX_TOP=/opt/apps/apps/binapps/matlab/third-party-toolboxes/mtex
MTEX_DIR=${MTEX_TOP}/${MTEX_VER}
MATLAB_DIR=/opt/apps/apps/binapps/matlab/R2019a
NFFT_DIR=${MTEX_TOP}/nfft-${NFFT_VER}
NFFT_INSTALLER_DIR=nfft-${NFFT_VER}
MTEX_INSTALLER=mtex-${MTEX_VER}.zip
NFFT_INSTALLER=nfft-${NFFT_VER}.tar.gz

.PHONY: copy-mex-files
copy-mex-files: ${MTEX_DIR} ${NFFT_DIR}
	cp ${NFFT_DIR}/lib/libnfsft.mexa64 ${MTEX_DIR}/extern/nfft/nfsftmex.mexa64
	cp ${NFFT_DIR}/lib/libnfsoft.mexa64 ${MTEX_DIR}/extern/nfft/nfsoftmex.mexa64

.PHONY: mtex-installer
mtex-installer: ${MTEX_INSTALLER}

${MTEX_INSTALLER}:
	wget https://github.com/mtex-toolbox/mtex/releases/download/mtex-${MTEX_VER}/$@

.PHONY: nfft-installer
nfft-installer: ${NFFT_INSTALLER}

${NFFT_INSTALLER}:
	wget https://www-user.tu-chemnitz.de/~potts/nfft/download/$@

.PHONY: install-mtex
install-mtex: ${MTEX_DIR}

${MTEX_DIR}: ${MTEX_INSTALLER}
	unzip -q $<
	mv mtex-${MTEX_VER} ${MTEX_VER}
	mv ${MTEX_VER} ${MTEX_TOP}
	touch $@

.PHONY: install-nfft
install-nfft: ${NFFT_DIR}

${NFFT_INSTALLER_DIR}: ${NFFT_INSTALLER}
	tar -xzf $<
	touch $@

${NFFT_DIR}: ${NFFT_INSTALLER_DIR}
	$</configure --with-matlab=${MATLAB_DIR} --enable-nfsft --enable-nfsoft --enable-portable-binary --prefix=${NFFT_DIR}
	make
	make install


.PHONY: clean-install
clean-install:
	rm -rf ${MTEX_DIR}
	rm -rf ${NFFT_INSTALLER_DIR}
	rm -rf ${NFFT_DIR} 

.PHONY: clean
clean: clean-install
	rm ${MTEX_INSTALLER}
	rm ${NFFT_INSTALLER}
