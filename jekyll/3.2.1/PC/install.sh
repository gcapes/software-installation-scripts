# This script is untested. The commands are correct, but I don't know if the sudo
# will be inherited if the script is run using "sudo . install.sh".

# ruby is needed to install jekyll
apt-get install ruby2.0

# the developer's version is also required
apt-get install ruby2.0-dev

# Check which version we now have
# I got this on my work laptop
# ruby 2.3.0p0 (2015-12-25 revision 53290) [x86_64-linux]
ruby --version

# Install jekyll
gem2.0 install jekyll

# check which version has been installed
jekyll --version
# Should be jekyll 3.2.1
