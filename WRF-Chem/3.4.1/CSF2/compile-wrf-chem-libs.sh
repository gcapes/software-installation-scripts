# Script to compile libraries required for WRF.

# Load intel compilers and mpi modules, set a load of environment variables for ease of installation
. wrf-chem-libs-env.sh

# The main directory for the libraries should already exist.
# George/Pen will have created it.

# Compile ZLIB library
# ====================
mkdir -p $ZROOT $LDIR/zlib/archive $LDIR/zlib/build
cp $ZFILE $LDIR/zlib/archive
cd $LDIR/zlib/build
tar -xzf ../archive/zlib-$ZVER.tar.gz
cd zlib-$ZVER
CC=icc CFLAGS=$FLAGS ./configure --prefix=$ZROOT 2>&1 | tee config-zlib-csf.log
make 2>&1 | tee make-zlib-csf.log
make check 2>&1 | tee make-check-zlib-csf.log
# Look for 
#                *** zlib test OK ***
#                *** zlib shared test OK ***
#                *** zlib 64-bit test OK ***
make install 2>&1 | tee make-install-zlib-csf.log

# HDF5
# ====
cd $LDIR
mkdir -p hdf/5
cd hdf/5
mkdir $HVER archive build
cp $HDFFILE archive
cd build
tar xzf ../archive/hdf5-$HVER.tar.gz
cd hdf5-$HVER
# Could look at install notes at this point
# less release_docs/INSTALL
CC=icc FC=ifort CXX=icpc CFLAGS=$FLAGS FCFLAGS=$FLAGS CXXFLAGS=$FLAGS ./configure --prefix=$HROOT --enable-fortran --enable-cxx --with-zlib=$ZROOT/include,$ZROOT/lib 2>&1 | tee config-hdf5-csf.log
make 2>&1 | tee make-hdf5-csf.log
make check 2>&1 | tee make-check-hdf5-csf.log
make install 2>&1 | tee make-install-hdf5-csf.log
make check-install 2>&1 | tee make-check-install-hdf5-csf.log


# NetCDF C libs
# =============
cd $LDIR
mkdir netcdf
cd netcdf
mkdir $NVER archive build
cp $NC_CFILE archive
cd build
tar xzf ../archive/netcdf-$NCVER.tar.gz
cd netcdf-$NCVER
# less INSTALL
# Note: There is NO space after $FLAGS before the double-quote character!!
CC=icc FC=ifort CXX=icpc CPPFLAGS=$FLAGS" -I$HROOT/include -I$ZROOT/include" LDFLAGS="-L$HROOT/lib -L$ZROOT/lib" ./configure --prefix=$NROOT --disable-dap 2>&1 | tee config-netcdfc-csf.log
make 2>&1 | tee make-netcdfc-csf.log
make check 2>&1 | tee make-check-netcdfc-csf.log
make install 2>&1 | tee make-install-netcdfc-csf.log

# NetCDF Fortran libs
# ===================
cd $LDIR/netcdf
# $NVER archive and build subdirs should already exist from above.
cp $NC_FFILE archive
cd build
tar xzf ../archive/netcdf-fortran-$NFVER.tar.gz
cd netcdf-fortran-$NFVER
# less README
# LD_LIBRARY_PATH needed to fix 'cannot determine size of off_t' error.
# Again, ensure no extra spaces between The $FLAGS and the doube-quote character!!
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$NROOT/lib CC=icc FC=ifort CXX=icpc CPPFLAGS=$FLAGS" -I$NROOT/include -I$HROOT/include -I$ZROOT/include" LDFLAGS="-L$NROOT/lib -L$HROOT/lib -L$ZROOT/lib" ./configure --prefix=$NROOT 2>&1 | tee config-netcdff-csf.log
make 2>&1 | tee make-netcdff-csf.log
make check 2>&1 | tee make-check-netcdff-csf.log
make install 2>&1 | tee make-install-netcdff-csf.log

# make check fails one of the tests. This is apparently not a problem - see email below from UCAR.
	# Hello Gerard,
	# 
	# This error is safe to ignore, but can be fixed by upgrading your netCDF-C to 4.4.1.1 (the latest
	# version).  This error message is a result of some changes in error codes from the HDF5 library,
	# which required changes in the netCDF-C library to handle properly.
	# 
	# I hope this helps, have a great day!
	# 
	# -Ward
	# 
	# > Dear UCAR,
	# >
	# > I have tried to compile the NetCDF Fortran 4.4.2 library, but have one failure when running makei
	# > check - see attached. This doesn't appear to cause a problem in use, but are you able to advise?
	# >
	# > Thanks
	# > Gerard

# Flex libs
# =========
cd $APPS
mkdir flex
cd flex
mkdir $FLEXVER archive build
cp $FLEXFILE archive
cd build
tar -xzf ../archive/flex-$FLEXVER.tar.gz
cd flex-$FLEXVER
CC=icc CFLAGS=$FLAGS ./configure --prefix=$FLEXROOT 2>&1 | tee config-flex-csf.log
make 2>&1 | tee make-flex-csf.log
make check 2>&1 | tee make-check-flex-csf.log
make install 2>&1 | tee make-install-flex-csf.log

# YACC
# ====
# YACC must be compiled from source - see notes in wrf-chem-installation-instructions.txt
mkdir $YROOT
cd $TOOLS/yacc
mkdir archive build
cp $YACCFILE archive
cd build
tar -xzf ../archive/byacc-$YVER.tar.gz
cd byacc-$YVER
CC=icc CFLAGS=$FLAGS ./configure --prefix=$YROOT 2>&1 | tee config-yacc-csf.log
make 2>&1 | tee make-yacc-csf.log
make check 2>&1 | tee make-check-yacc-csf.log
make install 2>&1 | tee make-install-yacc-csf.log

