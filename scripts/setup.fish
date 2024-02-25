#!/usr/bin/fish

# Load package functions into fish function path
set -l plate_fish_functions "$PLATE_PKG/scripts/functions"
if not contains $plate_fish_functions $fish_function_path
    set fish_function_path $plate_fish_functions $fish_function_path
end

# Check if the package is part of the current project
# set -l package_root_path (find_root_path $PLATE_PKG)
# set -l project_root_path (find_root_path (pwd -P))

# echo "Package: $package_root_path"
# echo "Project: $project_root_path"

# if test $package_root_path = $project_root_path
#     set -gx PLATE_ROOT "$package_root_path"
# else
#     echo "Error: The script and the current working directory are not in the same project." >&2
#     exit 1
# end
