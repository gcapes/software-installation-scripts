module load compilers/gcc/6.4.0
module load libs/boost/1.55.0
module load libs/gcc/cgal/4.9
module load tools/env/proxy
# OpenMPI is loaded with the boost module on CSF3

FVER=2.3.0
OF_ROOT=/opt/apps/apps/gcc/openfoam/${FVER}
mkdir -p ${OF_ROOT}
cd ${OF_ROOT}
wget http://downloads.sourceforge.net/foam/OpenFOAM-${FVER}.tgz
wget http://downloads.sourceforge.net/foam/ThirdParty-${FVER}.tgz
tar -xzf OpenFOAM-${FVER}.tgz
tar -xzf ThirdParty-${FVER}.tgz
FOAM_RC=${OF_ROOT}/OpenFOAM-${FVER}/etc/bashrc
FOAM_INST_DIR=${OF_ROOT}
CGAL_ARCH_PATH=$CGAL_DIR
BOOST_ARCH_PATH=${BOOST_ROOT}
. ${FOAM_RC}
cd ${OF_ROOT}/ThirdParty-${FVER}
./Allwmake 2>&1 | tee allwmake.log
cd ${OF_ROOT}/ThirdParty-${FVER}/scotch_6.0.0/src
make 2>&1 | tee make.log
cd $WM_PROJECT_DIR
./Allwmake 2>&1 | tee allwmake.log

# FOAM_INST_DIR should also be set in the module file, because early versions of OpenFOAM
# don't detect the installation directory when you source ${OF_ROOT}/etc/bashrc.
