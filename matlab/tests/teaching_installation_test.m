%TEACHING_INSTALLATION_TEST   Test that toolboxes are installed for
%                             teaching version
required_toolboxes = ["MATLAB", ...
    "Simulink", ...
    "Aerospace Blockset", ...
    "Aerospace Toolbox", ...
    "Control System Toolbox", ...
    "Computer Vision Toolbox", ...
    "Image Processing Toolbox", ...
    "Optimization Toolbox", ...
    "Robotics System Toolbox", ...
    "Robust Control Toolbox", ...
    "Signal Processing Toolbox", ...
    "Simscape", ...
    "Simscape Electrical", ...
    "Simscape Fluids", ...
    "Simscape Multibody", ...
    "Simulink 3D Animation", ...
    "Symbolic Math Toolbox", ...
    "System Identification Toolbox"];

%% Any toolboxes missing 
missing_toolboxes = are_toolboxes_installed(required_toolboxes);
assert(isempty(missing_toolboxes), "Installation is missing toolboxes!")

%% Any extra toolboxes
extra_toolboxes = detect_extra_toolboxes(required_toolboxes);
assert(isempty(extra_toolboxes), "Installation has extra toolboxes!")
