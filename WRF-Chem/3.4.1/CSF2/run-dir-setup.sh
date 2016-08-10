# Overview
# --------
# This script is designed for setting up multiple identical run directories to test
# execution speed for different numbers of cores for the same simulation.
# Create the run directory, then run this script.

# These variables must be set for the script to work:
# ---------------------------------------------------
# export WROOT=<WRF installation directory>
# export rundir=<where you run the job from>
# Set which namelist file you want to copy
export namelistdotinput=~/scratch/wrfchem-run/input_data/namelist.input
export wrfchemi_link_script=~/software_installation_scripts/WRF-Chem/3.4.1/CSF2/wrfchemi_link.sh
export metdir=~/scratch/wrfchem-run/input_data # <location of the met_em.d01.* files>
export wrfchemidir=$metdir
export wrfinput_d01=$metdir/wrfinput_d01
export wrfbdy_d01=$metdir/wrfbdy_d01
export wrflowinp_d01=$metdir/wrflowinp_d01

# These steps are required for all wrf-chem runs:
--------------------------------------------------
cp $WROOT/run $rundir
rm $rundir/*.exe 
for exe in $(ls $WROOT/run/*.exe);do ln -s $exe $rundir;done

# These steps depend on the simulation being run:
--------------------------------------------------
cp $namelistdotinput $rundir
for file in $(ls $metdir/met_em.d01*);do ln -s $file $rundir;done
cp $wrfchemidir/wrfchemi_d01* $rundir

# wrf.exe wants a file for each hour.
# Create links to the midnight files for each subsequent hour as required.
. $wrfchemi_link_script

echo "+:h:0:ccn1,ccn2,ccn3,ccn4,ccn5,ccn6" > $rundir/add_remove_var.txt

ln -s $wrfinput_d01 $rundir
ln -s $wrfbdy_d01 $rundir
ln -s $wrflowinp_d01 $rundir
