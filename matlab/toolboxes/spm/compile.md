# Compilation instructions for standalone version
The toolbox cannot just be included using `mcc -a <toolboxpath>` as you might normally do.
The SPM toolbox files are given as `.p` files rather than `.m` files, but the toolbox has a
compiler script to create a standalone version of the toolbox.
In order to compile a standalone version of the toolbox, you should open the MATLAB GUI,
navigate to the `config` directory, then run `spm_make_standalone`.

This will create a new directory `standalone` containing the compiled toolbox.

Alternatively the toolbox can be compiled using the commands:
```bash
MATLAB=/usr/local/matlab/R2019a/bin/matlab
VER=12.4
SPM=${HOME}/Downloads/spm${VER}
EXE_DIR=${HOME}/Downloads/spm-user-code/SPM${VER}-compiledwithmatlab
mkdir -p ${EXE_DIR}
${MATLAB} -batch "addpath ${SPM}; spm_jobman initcfg; spm_make_standalone('${EXE_DIR}');"
```
The `spm_make_standalone` function creates a few new files in the SPM directory,
then runs a MATLAB compiler command similar to below:
```
mcc -m -C -v -o spm12 -d $EXE_DIR -N -p $MATLAB_HOME/toolbox/signal/ -R singleCompThread -a $SPM12_ROOT $SPM12_ROOT/spm_standalone.m
```

# Compilation including user toolboxes
This is the default standalone installation so far.
In order to use user-written toolboxes, these should be copied into (or linked from)
`$SPM12_ROOT/toolbox`, before compiling using the above steps.
This is how Guillaume Flandin <g.flandin@ucl.ac.uk> suggested to do it.

# Alternative compilation including user toolboxes
For HPC I had previously favoured calling `mcc` directly and including the user toolbox with `-a user-toolbox-dir`,
because there could be a central install of SPM,
and the user could have their own toolbox wherever they want.
However, it does require a more involved command from the user, and `config/spm_make_standalone.m` has to be run first
by IT staff in order to create the extra files needed for the standalone version.

```bash
mcc -m -C -v -o spm12 -d $SPM12_STANDALONE -N -p $MATLAB_HOME/toolbox/signal -R singleCompThread -a $SPM12_ROOT -a path/to/mytoolbox $SPM12_ROOT/spm_standalone.m
```

# Usage in conjunction with user script
```bash
cd ${EXE_DIR}
USER_SCRIPT=/path/to/my_script.m
./run_spm12.sh $MATLAB_ROOT script ${USER_SCRIPT}
```

# User documentation on RI wiki:
http://ri.itservices.manchester.ac.uk/csf-apps/software/applications/matlab/#SPM

# Module file
The module file sets an environment variable SPM12_ROOT
