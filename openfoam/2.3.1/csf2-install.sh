module load compilers/gcc/6.3.0
module load mpi/gcc/openmpi/1.8
module load libs/gcc/boost/1.55.0
module load libs/gcc/cgal/4.9
module load tools/env/proxy

FVER=2.3.1
OF_ROOT=/opt/gridware/apps/gcc/openfoam/${FVER}
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
