#!/usr/bin/env fish

# Package setup of fish shell environment
set --global --export PLATE_PKG (realpath (dirname (status --current-filename))/..)
set --global --export PLATE_ROOT (pwd -P)

set --local registry_path $PLATE_PKG/imports/registry.mjs

argparse 'gulp=!test -f "$_flag_value"' -- $argv

set --local node_arguments $argv

if set --query _flag_gulp
    set --local gulp_bin "$PLATE_PKG/node_modules/gulp/bin/gulp.js"
    set --local gulp_cwd "--cwd='$PLATE_ROOT'"
    set --local gulp_file "--gulpfile='$PLATE_PKG/config/gulpfile.mjs'"
    set --global --export PLATE_GULPFILE (realpath $_flag_gulp)

    set --prepend node_arguments $gulp_bin $gulp_cwd $gulp_file
end

node --trace-warnings --import $registry_path $node_arguments
