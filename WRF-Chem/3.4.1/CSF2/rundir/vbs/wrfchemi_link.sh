#!/bin/bash

# Instructions:
# export rundir=<your run directory>
# export inputroot=<where the input files are> (contains bdy_files  biogenic_emission_files  emission_files  met_files  namelist_files)

# Where the job will run from 
rundir=$rundir				
# Where the input files are
emissiondir=$inputroot/emission_files

# Loop through files
for file in $(ls $emissiondir)
	# Strip time stamp from file name
	do
		filenamestub=${file%00:00:00}	
	
		# Loop through hours
		for hour in {0..23}
			do
			if [ $hour -lt 10 ]; then
				# Prefix with zero
				hour=0$hour
			fi
			time=$hour:00:00
			linkname=$filenamestub$time
			ln -sf $emissiondir/$file $rundir/$linkname
	done
done






