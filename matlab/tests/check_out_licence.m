function check_out_success = check_out_licence(feature_names)
    %CHECK_OUT_LICENCE    Attempt to check out licence for *feature_names*
    
    check_out_success = false(length(feature_names), 1);
    
    for i = 1:length(feature_names)
        toolbox = feature_names(i);
        if license('checkout', toolbox) == 1
            check_out_success(i) =  true;
            fprintf('Licence checked out for %s.\n', toolbox)
        else
            fprintf("Licence can't be checked out for %s\n", toolbox)
        end
    end