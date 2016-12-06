# Overview
# --------
# This script is designed for setting up multiple identical run directories to test
# execution speed for different numbers of cores for the same simulation.

# Instructions
# -------------
# Create the run directory
# Check/change the exported variables below
#	The idea is to have the input files in one directory, and link to them
#	for each run rather than copying the files to each new run directory.
# Set the following variables:
  # export WROOT=<WRF installation directory> (WRF installation script sets this)
  # export rundir=<where you run the job from>
# Run this script.

export inputroot=~/scratch/wrf-chem-vbs-run/vbs_testcase_files
# export namelistdotinput=$inputroot/namelist_files/namelist.input.setup_cbmz_mosaic_anthro_vbs_megan_emission
export namelistdotinput=$inputroot/namelist_files/namelist.input.5days 
export wrfchemi_link_script=~/software-installation-scripts/WRF-Chem/3.4.1-VBS/CSF2/wrfchemi_link.sh
export metdir=$inputroot/met_files # <location of the met_em.d01.* files>
export wrfinput_d01=$inputroot/wrfinput_d01
export wrfbdy_d01=$inputroot/wrfbdy_d01
export wrflowinp_d01=$inputroot/wrflowinp_d01

# These steps are required for all wrf-chem runs:
# --------------------------------------------------
cp $WROOT/run/* $rundir
rm $rundir/*.exe 
for exe in $(ls $WROOT/run/*.exe);do ln -s $exe $rundir;done

# These steps depend on the simulation being run:
# --------------------------------------------------
ln -sf $namelistdotinput $rundir/namelist.input
for file in $(ls $metdir/met_em.d01*);do ln -s $file $rundir;done
ln -s $inputroot/biogenic_emission_files/wrfbiochemi_d01 $rundir

# wrf.exe wants a wrfchemi file for each hour.
# Create links to the midnight files for each hour as required.
. $wrfchemi_link_script

ln -s $wrfinput_d01 $rundir
ln -s $wrfbdy_d01 $rundir
ln -s $wrflowinp_d01 $rundir
