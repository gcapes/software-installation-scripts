#!/bin/bash

# Installation script for MATLAB R2018a at the University of Manchester.
# Instructions:
	# Download the two iso files, and copy the contents of both to a new directory.
	# `cd` to that directory, which should contain:
	# install.sh common/ R2018a/
	# Run this script using `sudo ./install.sh`.


# Recombine installation files from the two .iso files
MVER=R2018a
INSTALLERDIR="${PWD}"/${MVER}
if [ ! -d "${INSTALLERDIR}"/archives/common ]; then
	# Common directory hasn't been copied.
	if [ -d common ]; then
		# Common dir exists at same level, so move it to the right place.
		mv common "${INSTALLERDIR}"/archives
	else
		# User error.
		echo -------- Error! --------
		echo \"common\" directory missing from current directory. Have you extracted both iso files?
		echo Refer back to installation instructions:
		echo "https://www.applications.itservices.manchester.ac.uk/show_product.php?id=98&tab=install"
		exit
	fi
fi

# Copy licence file to installation directory.
# Note US spelling of licences!
export LICENCEDIR=/Applications/MATLAB_${MVER}.app/licenses
sudo mkdir -p ${LICENCEDIR}
sudo cp "${INSTALLERDIR}"/network.lic ${LICENCEDIR}

# Run the installer
sudo "${INSTALLERDIR}"/install -inputFile "${INSTALLERDIR}"/installer_input.txt
