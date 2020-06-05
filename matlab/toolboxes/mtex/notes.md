# TL;DR
- Edit `startup` and `startup_mtex` to avoid modifying the path, and using the `builddocsearchdb` function
which can't be compiled.
- Include the `mtex/data` directory using `-a` when compiling
- Also include all the directories that the setup scripts add to the path, using `-I`
- See mtex-csf repo on UoMResearchIT github.

## startup
### Remove
% add root
addpath(fileparts(mfilename('fullpath')),0);

## startup_mtex
### Remove
% needs installation ?
 do_install(local_path);

### Replace
%fprintf([' ' MTEXversion '  ']);
 fprintf(' %s  ', MTEXversion);

### Remove
% setup search path
setMTEXPath(local_path);
p();	

### Remove
% make help searchable

if isempty(dir(fullfile(local_path,'doc','html','helpsearch*')))
  disp('Creating search data base for MTEX documentation.')
  builddocsearchdb(fullfile(local_path,'doc','html'));
end


# Interactive MATLAB
This toolbox installs easily and works with the user example nicely on my laptop.
On the CSF, the glibc version is too old, so external components need to be recompiled. 
Use the Makefile in this directory for that.

# Compiled (for CSF use)
When running a compiled version, if the MTEX toolbox root directory is included, setup runs and tries to set paths.
So while it compiles, it errors when you run it.
So I found out which directories were added to the path by `setup` when started interactively, and added those to
the compiled environment using the `-I` option.

MATLABPATH doesn't seem to make any difference to compiled applications - you include directories using `-I` or `-a` instead.
MATLABPATH is just like running `addpath` before you start MATLAB.

## Debugging journey
My first attempt was removing the setup file. This fixed the path setting problem, but stopped MTEX app data being set too,
giving a run-time error.

Using a setup script containing only `setMTEXpref('EulerAngleConvention','Bunge');` enables it to work. This suggestion came from the user.
This code is taken from `mtex_setttings`, which was previously called from setup -> setup_mtex -> mtex_settings
This feels like a bit of a hack solution - would this fix things for all use scenarios or just this particular example?
What about running `mtex_settings` too?

Call `mtex_settings` in `startup.m` i.e. this is all `startup` contains.
This doesn't work because `mtex_settings` line 105 has `setMTEXpref('CIFPath',       fullfile(mtexDataPath,'cif'));` calling mtexDataPath which thinks that 
> Data package not installed! 

I think this is because there is no appdata set.

In `startup_mtex` is where this stuff is set:
line 57: `setMTEXpref('DataPath',fullfile(local_path,'data'));`

## Call startup_mtex as original, to set app data
Ok, let's call `startup_mtex` from `startup` again (and edit `startup` so that's the only thing it does).
This gives a similar error to the original setup about modifying paths.

## but remove path modifications
Right, let's delete some of the path modification stuff we don't want in `startup_mtex`, 
because we're including the required paths at compile time:
% do_install(local_path);
% check_installation;

Try again ... 
Similar error but also get
> initializeWarning: Escaped character '\]' is not valid. See 'doc sprintf' for supported special characters.
> In startup_mtex (line 43)
  In startup (line 7)
 V1MCC4000MEC1000MCR1000x  ��q-���7W?�M,gنT�^h��� ...Error using mtexDataPath (line 18)
Data package not installed!

Let's try putting back in this bit from `do_install` at the end of `startup`:
`setappdata(0,'MTEXInstalled',true);`

... and
initializeWarning: Escaped character '\]' is not valid. See 'doc sprintf' for supported special characters.
> In startup_mtex (line 43)
  In startup (line 7)
 V1MCC4000MEC1000MCR1000x  ��q-���7W?�M,gنT�^h��� ...Error using mtexDataPath (line 18)
Data package not installed!

Error in mtex_settings (line 105)

Error in startup_mtex (line 62)

Error in startup (line 7)

Data package not installed!


Ok so since I called `startup_mtex` again, there's this new error about escaped character '\]'. WTF is this?

I don't understand why it works fine in interactive MATLAB, but using a format specifier with fprintf fixes this problem.

Now, onto the 'Data package not installed' error. The toolbox isn't finding this directory, even though it's there. Except that it's not!
Ah-ha! It needs to be in the compiled archive. Like here: /home/mbexegc2/.mcrCache9.6/exampl0/home/mbexegc2/Downloads/mtex/mtex-5.3/data
That directory has not been 'included' because it's not added to the MATLAB path by the installer.

## builddocsearchdb not found!
And the next error is that this function can't be found, despite the containing directory
being on the path. 
I think it can't be compiled for some reason, but it's not important for this use case (CSF).


## Add data directory to compilation options
Data package error gone!
Next error is about database creation and undefined function/variable:

Undefined function or variable 'builddocsearchdb'.

Error in startup_mtex (line 71)

Error in startup (line 1)

Undefined function 'builddocsearchdb' for input arguments of type 'char'.

Well `builddocsearchdb` is a built-in function, so let's just check that it's on the path for the deployed program:
/usr/local/matlab/R2019a/toolbox/matlab/helptools/builddocsearchdb.m

So yep, it's on the path in the deployed archive.


