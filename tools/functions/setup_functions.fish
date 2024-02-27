#!/usr/bin/fish

# Load package functions into fish function path
set -l plate_fish_functions "$PLATE_PKG/tools/functions"
if not contains $plate_fish_functions $fish_function_path
    set fish_function_path $plate_fish_functions $fish_function_path
end
