# Set variables for convenient directory naming
FVER=v1812
GCCVER=6.4.0
MPIVER=3.1.4
CGALVER=4.9
BOOSTVER=1.68.0

OF_ROOT=/opt/apps/apps/gcc/openfoam/$FVER

MODGCC=compilers/gcc/$GCCVER
MODMPI=mpi/gcc/openmpi/$MPIVER
MODCGAL=libs/gcc/cgal/$CGALVER
MODBOOST=libs/gcc/boost/$BOOSTVER


# Software required for compilation
 # gcc 4.8.5 or above
module load $MODGCC
if module list 2>&1 | grep $MODGCC; then
	echo Loaded module $MODGCC
else
	echo Failed to load module $MODGCC
	return
fi

 # flex (available by default on CSF)
 # OpenMPI
module load $MODMPI
if module list 2>&1 | grep $MODMPI; then
	echo $MODMPI loaded
else
	echo Failed to load module $MODMPI
	return
fi

 # Load CGAL module
module load $MODCGAL
if module list 2>&1 | grep $MODCGAL; then
	echo $MODCGAL loaded
else
	echo $Failed to load module $MODCGAL
	return
fi

 # Load boost module (required by CGAL)
module load $MODBOOST
if module list 2>&1 | grep $MODBOOST; then
	echo $MODBOOST loaded
else
	echo Failed to load $MODBOOST
	return
fi

# Set variables for ThirdParty compilation
BOOST_ARCH_PATH=$BOOST_ROOT
if [ -z $BOOST_ARCH_PATH ]
then
	echo BOOST_ARCH_PATH not set
	echo aborting
	return
fi

CGAL_ARCH_PATH=$CGAL_DIR
if [ -z $CGAL_ARCH_PATH ]
then
	echo CGAL_ARCH_PATH not set
	echo aborting
	return
fi


cd $OF_ROOT &&
# Download source files if this hasn't already been done
if [ ! -d OpenFOAM-$FVER ]
then
	wget -O - https://sourceforge.net/projects/openfoamplus/files/$FVER/OpenFOAM-$FVER.tgz | tar xvz
fi
if [ ! -d ThirdParty-$FVER ]
then
	wget -O - https://sourceforge.net/projects/openfoamplus/files/$FVER/ThirdParty-$FVER.tgz | tar xvz
fi


# Set the environment for OpenFOAM
 # Set FOAM_INST_DIR and WM_PROJECT_DIR
. OpenFOAM-$FVER/etc/bashrc &&

# Install third party software
 # CGAL and Paraview already built on CSF, so it's only Scotch which is built.
cd $OF_ROOT/ThirdParty-$FVER &&
./Allwmake 2>&1 | tee allwmake.log &&

# Install OpenFOAM
cd $OF_ROOT/OpenFOAM-$FVER &&
./Allwmake 2>&1 | tee allwmake.log &&

# Run tutorial tests
mkdir -p $FOAM_RUN
cp -r $FOAM_TUTORIALS $FOAM_RUN
cd $FOAM_RUN/tutorials
module load tools/gcc/gnuplot/5.2.7
./Alltest 2>&1 | tee alltest.log
