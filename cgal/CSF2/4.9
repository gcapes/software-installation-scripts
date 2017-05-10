# Official guide here: http://doc.cgal.org/latest/Manual/installation.html
module load tools/gcc/cmake/3.7.2
module load libs/gcc/boost/1.55.0

mkdir /opt/gridware/libs/gcc/cgal
cd /opt/gridware/libs/gcc/cgal
wget https://github.com/CGAL/cgal/archive/releases/CGAL-4.9.tar.gz
tar xzf CGAL-4.9.tar.gz
mv cgal-releases-CGAL-4.9 4.9-build
mkdir 4.9
cd build-4.9
export cgal_install_dir=/opt/gridware/libs/gcc/cgal/4.9/
cmake -DCMAKE_INSTALL_PREFIX=$cgal_install_dir . 2>&1 | tee cmake.log
cmake . 2>&1 | tee cmake.log
make 2>&1 | tee make.log
make install 2>&1 |  tee make-install.log

# When compiling OpenFOAM, the makefile looks for $CGAL_DIR/lib rather than lib64,
# so create a link to lib64.
cd $cgal_install_dir
ln -s lib64 lib
