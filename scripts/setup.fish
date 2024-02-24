#!/usr/bin/fish

# Set the root of the project environment variable
if not set -q PLATE_ROOT
    set -l current_path (status --current-filename | string trim)
    set -l cwd_path (pwd)

    set -l root_from_bin (find_project_root $current_path)
    set -l root_from_cwd (find_project_root $cwd_path)

    if test "$root_from_bin" = "$root_from_cwd"
        set -gx PLATE_ROOT "$root_from_bin"
    else
        echo "Error: The script and the current working directory are not in the same project." >&2
        exit 1
    end
end

# Set root package path as an environment variable
if not set -q PLATE_PACKAGE_ROOT
    set -l current_path (status --current-filename | string trim)
    set -gx PLATE_PACKAGE_ROOT (find_package_root $current_path)
end

# Load package functions into fish function path
set -l plate_fish_functions "$PLATE_PACKAGE_ROOT/scripts/functions"

if not contains $plate_fish_functions $fish_function_path
    set -gx fish_function_path $plate_fish_functions $fish_function_path
end

# Add package's "node_modules/.bin" folder to global executables PATH for the session
# set -l PLATE_NODE_MODULES_BIN "$PLATE_PACKAGE_ROOT/node_modules/.bin"

# if not contains $PLATE_NODE_MODULES_BIN $PATH
#     set -gx PATH $PLATE_NODE_MODULES_BIN $PATH
# end
