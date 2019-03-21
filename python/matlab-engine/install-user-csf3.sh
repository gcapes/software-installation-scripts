# Install MATLAB engine for python in user's home directory

module load apps/python3/3.6.4/gcc-4.8.5
module load apps/binapps/matlab/R2018a
cd $MATLAB_HOME/extern/engines/python
# The `--prefix=` bit is needed due to a bug on CentOS
# https://stackoverflow.com/questions/4495120/combine-user-with-prefix-error-with-setup-py-install
python setup.py build --build-base=$HOME/temp install --user --prefix=

# Usage from python is then like this:
  # >>> import matlab.engine
  # >>> eng = matlab.engine.start_matlab()
  # >>> tf = eng.isprime(37)
  # >>> print(tf)
  # True
  # >>> eng.quit()
 
  # Calling user-defined functions requires the .m files to be in the current directory.
  # >>> output = eng.myfunction(in1, in2)
