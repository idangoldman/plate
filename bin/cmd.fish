#!/usr/bin/env fish

set -l plate_fish_functions ../utils/scripts/functions

if not contains $plate_fish_functions $fish_function_path
    set -gx fish_function_path $plate_fish_functions $fish_function_path
end

set_env_vars

node --trace-warnings \
    --import $PLATE_PACKAGE_ROOT/utils/loaders/register.mjs \
    --import $PLATE_PACKAGE_ROOT/utils/global-plate-env.mjs \
    $PLATE_PACKAGE_ROOT/node_modules/gulp/bin/gulp \
    --gulpfile $PLATE_PACKAGE_ROOT/config/gulpfile.mjs \
    $argv
