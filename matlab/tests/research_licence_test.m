%RESEARCH_LICENCE_TEST   Test if toolbox licences are available.
%                        This is for the research licence 1560.

% To test a licence, you have to use the feature name of the product
% as it appears in the licence file, rather than the actual name of the
% toolbox.
feature_name = [...
    "MATLAB", ...
    "SIMULINK", ...
    "Bioinformatics_Toolbox", ...
    "Control_Toolbox", ...
    "RTW_Embedded_Coder", ...
    "Financial_Toolbox", ...
    "Fuzzy_Toolbox", ...
    "GADS_Toolbox", ...
    "Image_Toolbox", ... 
    "MATLAB_Coder", ...   
    "Compiler", ...   
    "Neural_Network_Toolbox", ...
    "Optimization_Toolbox", ...
    "Distrib_Computing_Toolbox", ...
    "PDE_Toolbox", ...
    "Robust_Toolbox", ...
    "Signal_Toolbox", ...
    "Virtual_Reality_Toolbox", ...
    "Real-Time_Workshop", ...
    "Simulink_Control_Design", ...
    "Statistics_Toolbox", ...
    "Symbolic_Toolbox", ...
    "Identification_Toolbox", ...
    "Wavelet_Toolbox" ...
    ];

if computer('arch') == "win64"
    % OPC toolbox only installed for Windows.
    % Not testing licence availability for NAG toolbox because it's third
    % party and licenced separately.
    feature_name = [feature_name, "OPC_Toolbox"];
end

%% Is correct licence in use
assert(license == "1560", "Incorrect licence number in use!")

%% Do licences exist
licence_exists = do_licences_exist(feature_name);
assert(all(licence_exists), "Licence doesn't exist for all toolboxes!")

%% Can licences be checked out
check_out_success = check_out_licence(feature_name);
assert(all(check_out_success), 'Unable to check out a licence for all products!')