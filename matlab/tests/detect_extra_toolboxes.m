function extra_toolboxes = detect_extra_toolboxes(required_toolboxes)
    %DETECT_EXTRA_TOOLBOXES   Determine whether toolboxes not listed in
    %                         *required_toolboxes* are installed.
    
    product_info = ver;
    installed_toolboxes = string({product_info.Name});
    not_required = false(length(installed_toolboxes), 1);
    
    % Check that toolboxes which are installed should be installed.
    for i = 1:length(installed_toolboxes)
        toolbox = installed_toolboxes(i);
        if ~any(required_toolboxes == toolbox)
            % Installed toolbox is not required
            not_required(i) = true;
            fprintf("!! %s should not be installed !!\n", toolbox)
        end
    end
    
    extra_toolboxes = installed_toolboxes(not_required);