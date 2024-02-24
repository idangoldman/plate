#!/usr/bin/fish

# Load package functions into fish function path
set -l plate_fish_functions "$PLATE_PKG/scripts/functions"
if not contains $plate_fish_functions $fish_function_path
    set fish_function_path $plate_fish_functions $fish_function_path
end

# Set the root of the project environment variable
if not set -q PLATE_ROOT
    set -l package_root_path (find_root_path $PLATE_PKG)
    set -l project_root_path (find_root_path (pwd -P))

    if test $package_root_path = $project_root_path
        set -gx PLATE_ROOT "$package_root_path"
    else
        echo "Error: The script and the current working directory are not in the same project." >&2
        exit 1
    end
end

# Set root package path as an environment variable
# if not set -q PLATE_PKG
#     set -gx PLATE_PKG (find_root_path $PLATE_PKG)
# end

# Add package's "node_modules/.bin" folder to global executables PATH for the session
# set -l PLATE_NODE_BIN "$PLATE_PKG/node_modules/.bin"

# if not contains $PLATE_NODE_BIN $PATH
#     set -gx PATH $PLATE_NODE_BIN $PATH
# end
