# WRF-Chem 3.4.1 installation on CSF2
I used these scripts to largely automate the installation.
These files describe a fresh installation (without the use of any modules files).

- wrf-chem-installation-instructions.txt describes the process.
- . wrf-chem-libs-env.sh
- . compile-wrf-chem-libs.sh
- . wrf-chem-apps-env.sh
- . wrf-chem-apps-make-dirs.sh
- refer to wrf-chem-installation-instructions.txt for a few manual steps

## Recompilation
Instead of sourcing compile-wrf-chem-libs.sh, load the following module files:

- module load libs/intel-15.0/zlib/1.2.8
- module load libs/intel-15.0/hdf/5/1.8.16
- module load libs/intel-15.0/netcdf/4.4.0
- module load tools/intel-15/yacc/20160606_wrf-chem-3.4.1
- module load apps/intel-15.0/flex/2.5.3
