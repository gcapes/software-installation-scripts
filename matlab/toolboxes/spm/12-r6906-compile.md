# Compilation instructions for standalone version
The toolbox cannot just be included using mcc -a <toolboxpath> as you might normally do.
The SPM toolbox files are given as .p files rather than .m files, and the toolbox has a
compiler script to create a standalone version of the toolbox.
In order to compile a standalone version of the toolbox, you should open the MATLAB GUI,
navigate to the `config` directory, then run `spm_make_standalone`.
Alternatively the toolbox can be compiled using the commands:
```bash
export SPM12_STANDALONE=/scratch/spm12-standalone
mkdir $SPM12_STANDALONE
mcc -m -C -v -o spm12 -d $SPM12_STANDALONE -N -p $MATLAB_HOME/toolbox/signal/ -R singleCompThread -a $SPM12_ROOT $SPM12_ROOT/spm_standalone.m
```

# Compilation including user toolboxes
This is the default standalone installation so far.
In order to use user-written toolboxes, these should be copied into (or linked from)
`$SPM12_ROOT/toolbox`, before compiling using the above steps.
This is how Guillaume Flandin <g.flandin@ucl.ac.uk> suggested to do it.

# Neater compilation including user toolboxes
A neater way which also looks to work is to include any user toolbox folders using `-a` like this:
```bash
mcc -m -C -v -o spm12 -d $SPM12_STANDALONE -N -p $MATLAB_HOME/toolbox/signal -R singleCompThread -a $SPM12_ROOT -a path/to/mytoolbox $SPM12_ROOT/spm_standalone.m
```

# Usage in conjunction with user script
```bash
./run_spm12.sh $MATLAB_ROOT script <userscript.m>
```

# User documentation on RI wiki:
http://ri.itservices.manchester.ac.uk/csf-apps/software/applications/matlab/#SPM

# Module file
The module file sets an environment variable SPM12_ROOT
