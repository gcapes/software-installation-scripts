# Compilation instructions for standalone version
The toolbox cannot just be included using `mcc -a <toolboxpath>` as you might normally do.
Some of the SPM toolbox files are given as `.p` files rather than `.m` files, but the toolbox has a
MATLAB function to create a standalone version of the toolbox: `config/spm_make_standalone.m`.
This will create a new directory `standalone` containing the compiled toolbox.

Alternatively the toolbox can be compiled using the commands:
```bash
VER=12.4
SPM_TOOLBOX=${HOME}/Downloads/spm${VER}
EXE_DIR=${HOME}/Downloads/SPM${VER}-standalone
mkdir -p ${EXE_DIR}
matlab -batch "addpath ${SPM}; spm_jobman initcfg; spm_make_standalone('${EXE_DIR}');"
```
The `spm_make_standalone` function creates a few new files in the SPM toolbox directory,
then runs a MATLAB compiler command similar to below:
```
mcc -m -C -v -o spm12 -d $EXE_DIR -N -p $MATLAB_HOME/toolbox/signal/ -R singleCompThread -a $SPM12_ROOT $SPM12_ROOT/spm_standalone.m
```

# Compilation including user toolboxes
This is the default standalone installation so far.
In order to use user-written toolboxes, these should be copied into (or linked from)
`$SPM_TOOLBOX/toolbox`, before compiling using the above steps.
This is how Guillaume Flandin <g.flandin@ucl.ac.uk> suggested to do it.


# Usage in conjunction with user script
```bash
cd ${EXE_DIR}
USER_SCRIPT=/path/to/my_script.m
./run_spm12.sh $MATLAB_ROOT script ${USER_SCRIPT}
```

# CSF usage
## Module file
On the CSF, the module file instructs users to copy the SPM toolbox directory to their scratch space,
and to compile as above.

## Template lob scripts
- [compilation script](compile.sh)
- [job script](run.sh)
