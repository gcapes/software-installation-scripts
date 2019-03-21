# Installation
# ------------
# The instructions here are incomplete: https://openfoam.org/download/4-1-source/
# Instead, follow instructions here: https://openfoamwiki.net/index.php/Installation/Linux/OpenFOAM-4.1/Ubuntu
# 
# Compilation requires gcc > 4.5.
# Don't compile ParaView, so don't need cmake, or QT.
# Do need OpenMPI.

OF_VER=4.1
OF_DIR=/opt/apps/apps/gcc/openfoam/${OF_VER}
# Override default installation directory
export FOAM_INST_DIR=${OF_DIR}
ETC_DIR=${OF_DIR}/OpenFOAM-${OF_VER}/etc
FOAM_RC=${ETC_DIR}/bashrc

# Load modules
module load compilers/gcc/6.4.0
module load libs/gcc/boost/1.68.0
module load mpi/gcc/openmpi/3.1.3
module load libs/gcc/cgal/4.9
module load tools/env/proxy


# Create directory and download source code
mkdir -p $OF_DIR
cd $OF_DIR
wget -O - http://dl.openfoam.org/source/4-1 | tar xz
wget -O - http://dl.openfoam.org/third-party/4-1 | tar xz
mv OpenFOAM-4.x-version-4.1 OpenFOAM-4.1
mv ThirdParty-4.x-version-4.1 ThirdParty-4.1

# We have built CGAL separately, so no need to edit ThirdParty-4.1/makeCGAL

# We need to set 
#	export CGAL_ARCH_PATH=$CGAL_DIR
#	export BOOST_ARCH_PATH=$BOOST_ROOT
# but OpenFOAM 4.1 overrides BOOST_ARCH_PATH and CGAL_ARCH_PATH if set before
# sourcing the bashrc file (seems to be the version of OpenFOAM which does this).
# So we edit the CGAL config file.
CGAL_CONFIG=${ETC_DIR}/config.sh/CGAL
sed -i 's/=\$common_path\/\$boost_version/=\$BOOST_ROOT/' $CGAL_CONFIG
sed -i 's/=\$common_path\/\$cgal_version/=\$CGAL_ROOT/' $CGAL_CONFIG
. ${FOAM_RC}

# Install third party software (just scotch)
cd ${OF_DIR}/ThirdParty-4.1
./Allwmake 2>&1 | tee allwmake.log

# Install OpenFOAM
cd ${OF_DIR}/OpenFOAM-4.1
./Allwmake 2>&1 | tee allwmake.log

# Run tutorial tests
mkdir -p $FOAM_RUN
cp -r $FOAM_TUTORIALS $FOAM_RUN
cd $FOAM_RUN/tutorials
./Alltest 2>&1 | tee alltest.log
