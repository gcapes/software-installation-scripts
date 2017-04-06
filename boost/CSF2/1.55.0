# Boost 1.55.0 installtion

# Create directory
mkdir /opt/gridware/libs/gcc/boost/1.55.0

# Download source
wget http://sourceforge.net/projects/boost/files/boost/1.55.0/boost_1_55_0.tar.bz2

# Unpack
tar xjf boost_1_55_0.tar.bz2
cd boost_1_55_0
./bootstrap.sh --prefix=/opt/gridware/libs/gcc/boost/1.55.0 2>&1 | tee boostrap.log
./b2 install

