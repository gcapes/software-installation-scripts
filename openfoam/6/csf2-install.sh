# Set variables for convenient directory naming
FVER=6
OF_ROOT=/opt/gridware/apps/gcc/openfoam/$FVER
cd $OF_ROOT

# Download source files
wget -O - http://dl.openfoam.org/source/$FVER | tar xvz
wget -O - http://dl.openfoam.org/third-party/$FVER | tar xvz

# Rename download directories
mv OpenFOAM-$FVER-version-$FVER OpenFOAM-$FVER
mv ThirdParty-$FVER-version-$FVER ThirdParty-$FVER

# Software for compilation
 # gcc 4.8 or above
module load compilers/gcc/6.3.0
 # flex (available by default on CSF)
 # OpenMPI
module load mpi/gcc-6/openmpi/1.8

# Set the environment for OpenFOAM
 # Set FOAM_INST_DIR and WM_PROJECT_DIR
. OpenFOAM-$FVER/etc/bashrc

# Install third party software
 # We do this separately for CGAL, don't build Paraview, so it's only
 # Scotch which is built.
 # Load CGAL module
module load libs/gcc/cgal/4.9
 # Boost is required by CGAL
module load libs/gcc/boost/1.57.0
# For OpenFOAM 4.1, editing etc/config.sh/CGAL worked, however I couldn't figure it out for 5.0.
# So instead, just set two environment variables from the shell:
BOOST_ARCH_PATH=$BOOST_ROOT
CGAL_ARCH_PATH=$CGAL_DIR

# Install third party software (just scotch)
cd $OF_ROOT/ThirdParty-$FVER
./Allwmake 2>&1 | tee allwmake.log

# Install OpenFOAM
cd $OF_ROOT/OpenFOAM-$FVER
./Allwmake 2>&1 | tee allwmake.log

# Run tutorial tests
mkdir -p $FOAM_RUN
cp -r $FOAM_TUTORIALS $FOAM_RUN
cd $FOAM_RUN/tutorials
./Alltest 2>&1 | tee alltest.log
