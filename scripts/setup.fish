#!/usr/bin/fish

# Load package functions into fish function path
set -l plate_fish_functions "$PLATE_SCRIPTS_PATH/scripts/functions"

if not contains $plate_fish_functions $fish_function_path
    set fish_function_path $plate_fish_functions $fish_function_path
end

# Set the root of the project environment variable
if not set -q PLATE_ROOT
    # TODO: This code is not working, both paths are the same
    set -l package_path (find_root_path $PLATE_SCRIPTS_PATH)
    set -l project_path (find_root_path (pwd))

    echo "Package Path: $package_path"
    echo "Project Path: $project_path"

    if test "$package_path" = "$project_path"
        set -gx PLATE_ROOT "$package_path"
    else
        echo "Error: The script and the current working directory are not in the same project." >&2
        exit 1
    end
end

# Set root package path as an environment variable
if not set -q PLATE_PACKAGE_ROOT
    set -gx PLATE_PACKAGE_ROOT (find_root_path $PLATE_SCRIPTS_PATH)
end

# Add package's "node_modules/.bin" folder to global executables PATH for the session
# set -l PLATE_NODE_MODULES_BIN "$PLATE_PACKAGE_ROOT/node_modules/.bin"

# if not contains $PLATE_NODE_MODULES_BIN $PATH
#     set -gx PATH $PLATE_NODE_MODULES_BIN $PATH
# end
