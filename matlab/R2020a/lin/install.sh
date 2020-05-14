#!/bin/bash

# Installation script for MATLAB R2019a at the University of Manchester.
# Instructions:
	# Download the three iso files, and copy the contents of all three into a new directory.
	# `cd` to that directory, which should contain:
	# archives/ install.sh common/ examples/ R2020a/
	# Run this script using `sudo ./install.sh`.


# Recombine installation files from the two .iso files
MVER=R2020a
INSTALLERDIR="${PWD}"/${MVER}
if [ ! -d "${INSTALLERDIR}"/archives ]; then
	# archives directory hasn't been copied.
	if [ -d archives ]; then
		# archives dir exists at same level, so move it to the right place.
		mv archives "${INSTALLERDIR}"
	else
		# User error.
		echo -------- User error! --------
		echo \"archives\" directory missing from current directory. Have you extracted all three iso files?
		echo Refer back to installation instructions:
		echo "https://www.applications.itservices.manchester.ac.uk/show_product.php?id=98&tab=install"
		exit
	fi
fi

if [ ! -d "${INSTALLERDIR}"/archives/common ]; then
	# Common directory hasn't been copied.
	if [ -d common ]; then
		# Common dir exists at same level, so move it to the right place.
		mv common "${INSTALLERDIR}"/archives
	else
		# User error.
		echo -------- User error! --------
		echo \"common\" directory missing from current directory. Have you extracted all three iso files?
		echo Refer back to installation instructions:
		echo "https://www.applications.itservices.manchester.ac.uk/show_product.php?id=98&tab=install"
		exit
	fi
fi

if [ ! -d "${INSTALLERDIR}"/archives/common/examples ]; then
	# Examples directory hasn't been copied.
	if [ -d examples ]; then
	# Examples dir exists at same level, so move it to the right place.
		mv examples "${INSTALLERDIR}"/archives/common
	else
		# User error.
		echo -------- User error! --------
		echo \"examples\" directory missing from current directory. Have you extracted all three iso files?
		echo Refer back to installation instructions:
		echo "https://www.applications.itservices.manchester.ac.uk/show_product.php?id=98&tab=install"
		exit
	fi
fi

# Copy licence file to installation directory.
	# The installer has changed in recent years and now requires
	# the full path to the licence file.
	# Copying to the final destination seems as good a solution as any.
	# Note US spelling of licences!
export LICENCEDIR=/usr/local/matlab/${MVER}/licenses
sudo mkdir -p ${LICENCEDIR}
sudo cp "${INSTALLERDIR}"/network.lic ${LICENCEDIR}
sudo chmod +r ${LICENCEDIR}/network.lic

# Run the installer
sudo "${INSTALLERDIR}"/install -inputFile "${INSTALLERDIR}"/installer_input.txt
