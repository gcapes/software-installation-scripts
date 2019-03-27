module load compilers/gcc/6.4.0
module load mpi/gcc/openmpi/3.1.3
module load libs/gcc/boost/1.68.0
module load libs/gcc/cgal/4.9
module load tools/env/proxy

OF_VER=2.4.0
OF_DIR=/opt/apps/apps/gcc/openfoam/${OF_VER}
ETC_DIR=${OF_DIR}/OpenFOAM-${OF_VER}/etc
FOAM_RC=${ETC_DIR}/bashrc

# Override default installation directory
FOAM_INST_DIR=${OF_DIR}

mkdir -p ${OF_DIR}
cd ${OF_DIR}
wget http://downloads.sourceforge.net/foam/OpenFOAM-${OF_VER}.tgz
wget http://downloads.sourceforge.net/foam/ThirdParty-${OF_VER}.tgz
tar -xzf OpenFOAM-${OF_VER}.tgz
tar -xzf ThirdParty-${OF_VER}.tgz
# We need to:
#	export CGAL_ARCH_PATH=$CGAL_DIR
#	export BOOST_ARCH_PATH=$BOOST_ROOT
# but old versions of OpenFOAM ignore existing values for BOOST_ARCH_PATH and CGAL_ARCH_PATH
# and set their default values when sourcing the bashrc file.
# So we edit the CGAL config file.
CGAL_CONFIG=${ETC_DIR}/config/CGAL.sh
sed -i 's/BOOST_ARCH_PATH=.*/BOOST_ARCH_PATH=\$BOOST_ROOT/' $CGAL_CONFIG
sed -i 's/CGAL_ARCH_PATH=.*/CGAL_ARCH_PATH=\$CGAL_DIR/' $CGAL_CONFIG
. ${FOAM_RC}

cd ${OF_DIR}/ThirdParty-${OF_VER}
./Allwmake 2>&1 | tee allwmake.log
cd ${OF_DIR}/ThirdParty-${OF_VER}/scotch_6.0.0/src
make 2>&1 | tee make.log
cd $WM_PROJECT_DIR
./Allwmake 2>&1 | tee allwmake.log

# FOAM_INST_DIR should also be set in the module file, because early versions of OpenFOAM
# don't detect the installation directory when you source $FOAM_RC.
