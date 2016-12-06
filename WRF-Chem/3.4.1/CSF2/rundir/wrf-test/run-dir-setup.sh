# Overview
# --------
# This script is designed for setting up multiple identical run directories to test
# execution speed for different numbers of cores for the same simulation.

# Instructions
# -------------
# Create the run directory
# Check/change the exported variables below
# Set the following variables:
  # export WROOT=<WRF installation directory> (already set by installation script)
  # export rundir=<where you run the job from>
# Run this script.

export namelistdotinput=~/scratch/wrfchem-run/input_data/namelist.input
export wrfchemi_link_script=~/software-installation-scripts/WRF-Chem/3.4.1/CSF2/wrfchemi_link.sh
export metdir=~/scratch/wrfchem-run/input_data # <location of the met_em.d01.* files>
export wrfchemidir=$metdir
export wrfinput_d01=$metdir/wrfinput_d01
export wrfbdy_d01=$metdir/wrfbdy_d01
export wrflowinp_d01=$metdir/wrflowinp_d01

# These steps are required for all wrf-chem runs:
# --------------------------------------------------
cp $WROOT/run/* $rundir
rm $rundir/*.exe 
for exe in $(ls $WROOT/run/*.exe);do ln -s $exe $rundir;done

# These steps depend on the simulation being run:
# --------------------------------------------------
cp $namelistdotinput $rundir
for file in $(ls $metdir/met_em.d01*);do ln -s $file $rundir;done
for file in $(ls $metdir/wrfchemi_d01*);do ln -s $file $rundir;done

# wrf.exe wants a file for each hour.
# Create links to the midnight files for each subsequent hour as required.
export startdir=$(pwd)
cd $rundir # Doug's script operates on the current directory
. $wrfchemi_link_script
cd $startdir

echo "+:h:0:ccn1,ccn2,ccn3,ccn4,ccn5,ccn6" > $rundir/add_remove_var.txt

ln -s $wrfinput_d01 $rundir
ln -s $wrfbdy_d01 $rundir
ln -s $wrflowinp_d01 $rundir
