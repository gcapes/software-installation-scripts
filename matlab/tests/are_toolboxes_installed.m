function missing_toolboxes = are_toolboxes_installed(required_toolboxes)
%ARE_TOOLBOXES_INSTALLED    Test whether required_toolboxes are installed
    product_info = ver;
    installed_toolboxes = string({product_info.Name});
    is_installed = false(length(required_toolboxes), 1);
    
    % Report installed toolboxes
    for i = 1:length(required_toolboxes)
        toolbox = required_toolboxes(i);
        if any(installed_toolboxes == toolbox)
            is_installed(i) = true;
            fprintf('%s is installed.\n', toolbox)
        end
    end
    
    % Report missing toolboxes
    missing_toolboxes = required_toolboxes(~is_installed);
    if ~ isempty(missing_toolboxes)
        for i = 1:length(missing_toolboxes)
            toolbox = missing_toolboxes(i);
            fprintf("!! %s is not installed !!\n", toolbox)
        end
    end
