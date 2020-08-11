wget http://people.ee.ethz.ch/~mpt/tbx/pool/mpt3/3_2_1/mpt3-3_2_1.tgz
wget http://people.ee.ethz.ch/~mpt/tbx/pool/mpt3doc/3_0_4/mpt3doc-3_0_4.tgz
wget http://people.ee.ethz.ch/~mpt/tbx/pool/cddmex/1_0_1/cddmex_1_0_1_GLNXA64.tgz
wget http://people.ee.ethz.ch/~mpt/tbx/pool/fourier/1_0/fourier_1_0_glnxa64.zip
wget http://people.ee.ethz.ch/~mpt/tbx/pool/glpkmex/1_0/glpkmex_1_0_glnxa64.zip
wget http://people.ee.ethz.ch/~mpt/tbx/pool/hysdel2/2_0_6/GLNXA64/hysdel.zip
wget http://people.ee.ethz.ch/~mpt/tbx/pool/lcp/1_0_3/lcp_1_0_3_GLNXA64.tgz
wget http://people.ee.ethz.ch/~mpt/tbx/pool/sedumi/1_3/sedumi_1_3_glnxa64.zip
wget http://people.ee.ethz.ch/~mpt/tbx/pool/espresso/1_0/espresso_linux.tgz
wget https://github.com/yalmip/YALMIP/archive/master.zip

INSTALL_DIR=/opt/apps/apps/binapps/matlab/third-party-toolboxes/mpt3/3.2.1
mkdir -p ${INSTALL_DIR}

for file in *.zip
do
	unzip ${file} -d ${INSTALL_DIR}
done

for file in *.tgz
do
	tar -xzf ${file} -C ${INSTALL_DIR}
done
