function licence_exists = do_licences_exist(required_toolboxes)
    %DO_LICENCES_EXIST   Check that licences exist for installed products
    
    licence_exists = false(length(required_toolboxes), 1);
    for i = 1:length(required_toolboxes)
        toolbox = required_toolboxes(i);
        if license('test', toolbox)
            licence_exists(i) = true;
            fprintf('Licence exists for %s.\n', toolbox)
        else
            fprintf('!! No licence exists for %s !!\n', toolbox)
        end
    end