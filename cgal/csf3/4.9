# Official guide here: http://doc.cgal.org/latest/Manual/installation.html
module load tools/gcc/cmake/3.12.1
module load libs/boost/1.60.0

CGAL_ROOT=/opt/apps/libs/gcc/cgal
CGAL_VER=4.9
CGAL_INST_DIR=${CGAL_ROOT}/${CGAL_VER}

cd ${CGAL_ROOT}
mkdir ${CGAL_INST_DIR}
wget https://github.com/CGAL/cgal/archive/releases/CGAL-${CGAL_VER}.tar.gz
tar xzf CGAL-${CGAL_VER}.tar.gz
mv cgal-releases-CGAL-${CGAL_VER} ${CGAL_VER}-build
mkdir ${CGAL_VER}
cd ${CGAL_VER}-build
export cgal_install_dir=${CGAL_INST_DIR}
cmake -DCMAKE_INSTALL_PREFIX=$cgal_install_dir . 2>&1 | tee cmake.log
cmake . 2>&1 | tee cmake.log
make 2>&1 | tee make.log
make install 2>&1 |  tee make-install.log

# When compiling OpenFOAM, the makefile looks for $CGAL_DIR/lib rather than lib64,
# so create a link to lib64.
cd $cgal_install_dir
ln -s lib64 lib
