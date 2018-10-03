# Create a new virtual environment,
# setting the version of python as appropriate.
# I'm using the version specified by `python --version`.
conda create --name netcdf4 python=3.6.3 

# Activate the new virtual environment
# On Windows this command is just `activate netcdf4`
source activate netcdf4

# Install netCDF4 package with Conda
conda install netcdf4

# Say Yes when prompted to install packages. 
# This should install all the requirements for the netCDF4 package.

# In order to use Spyder with this new environment, you need to install
# further packages:
conda install cloudpickle
conda install ipykernel

# Start spyder, then tools/preferences/python interpreter/
#	/use the following python interpreter/(browse to your environment)
# Restart the kernel (click in console, then `ctrl + .`)

# Test using example script adapted from http://unidata.github.io/netcdf4-python/#section1
# to use python 3.
python test.py
