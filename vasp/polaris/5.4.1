# Installation script for VASP on Polaris (source this file).

# Ignoring instructions here: http://cms.mpi.univie.ac.at/vasp/vasp/Installation_VASP.html
# But instead following Pen's instructions on wiki
# http://ri.itservices.manchester.ac.uk/restricted/support/software-installs/vasp-5-4-1/

# READ BEFORE RUNNING THIS SCRIPT
# 1. 	Back up the installation media - when untarring the patch files 
# 	the original gz files are deleted
# 2. 	Create the directories, and restrict access
#	/apps/manchester/VASP/<version>/archive-backup


# set some environment variables (change to suit your installation)
export vasp_install_files=/apps/manchester/VASP/archive
export vasp_ver=5.4.1
export vasp_root=/apps/manchester/VASP/$vasp_ver
export vasp_targz=vasp.$vasp_ver.tar.gz
export vasp_serial_makefile=/apps/manchester/VASP/vasp-makefile.include--serial
export vasp_par_makefile=/apps/manchester/VASP/vasp-makefile.include--par

# unpack vasp tar.gz archive
cd $vasp_install_files
tar zxvf $vasp_targz 
mv vasp.$vasp_ver/* $vasp_root

# unzip patch archives
# This creates files, but deletes the .gz archives in the process
for p in $(ls patch*); do
	gunzip $p
done

# Copy patch files to vasp root
cp patch* $vasp_root

# Patch files
cd $vasp_root
for p in $(ls patch*); do
	patch -p1 < $p
done

# It looks like making an mkl wrapper is not required, so I've skipped that section.

# Serial build
# Create serial makefile in vasp_root
cp $vasp_serial_makefile makefile.include
make all 2>&1 | tee make-serial.log

# Tidy up serial build
# back up makefile, including any changes which were required
cp makefile.include makefile.include--serial

# Move serial build directory and create new build directory so parallel build doesn't fail
mv build build-serial
mkdir build

# Rename executables
cd bin
mv vasp_gam vasp_gam_serial
mv vasp_ncl vasp_ncl_serial
mv vasp_std vasp_std_serial

# Parallel build
# Copy makefile from home directory
cd $vasp_root
cp $vasp_par_makefile makefile.include
# openmpi module file should already be loaded
make all 2>&1 | tee make-par.log

# Tidy up parallel build
# back up makefile for future builds
mv makefile.include makefile.include--par

# Rename build dir so it doesn't get overwritten
mv build build--par

# Rename executables
cd bin
mv vasp_gam vasp_gam_par
mv vasp_ncl vasp_ncl_par
mv vasp_std vasp_std_par

# Pseudopotentials
mkdir $vasp_root/pseudopotentials
cd $vasp_install_files # installation media directory
# Unpack each pot*.tar.gz file in to pseudopotentials dir
# Vienna instructions say to make a new directory for each compressed file
# Certainly tring to unpack them all into the same directory didn't work!
#for targz in $(ls potpaw*.tar.gz); do
#	potdir=${targz%'.tar.gz'}
#	mkdir $vasp_root/pseudopotentials/$potdir
#	tar zxvf $targz -C $vasp_root/pseudopotentials/$potdir
#done

# Same process for the *.tgz files
#for tgz in $(ls potpaw*.tgz); do
#	export potdir=${tgz%'.tgz'}
#	echo $potdir
#	mkdir $vasp_root/pseudopotentials/$potdir
#	echo $vasp_root/pseudopotentials/$potdir
#	tar zxvf $tgz -C $vasp_root/pseudopotentials/$potdir
#done

file_count=0
n_files=$(ls pot* | wc -l)
for pot_file_name in $(ls pot*); do
	# Give a progress report
	((file_count++))
	echo 'Processing file' $file_count'/'$n_files

	# strip file extensions	
	pot_dir=${pot_file_name%.tar.gz}
	pot_dir=${pot_dir%.tgz}
	# complete directory names	
	pot_dir=$vasp_root/pseudopotentials/$pot_dir
	
	# Make directories and untar files to install directory
	mkdir $pot_dir
	pot_file=$vasp_install_files/$pot_file_name	
	tar zxvf $pot_file_name -C $pot_dir
done

# Installation testing:
# Example problems: http://cms.mpi.univie.ac.at/wiki/index.php/VASP_example_calculations
