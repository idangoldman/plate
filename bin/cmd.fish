#!/usr/bin/env fish

# Package setup of fish shell environment
set -gx PLATE_SCRIPTS_PATH (realpath (dirname (status --current-filename))/..)
source $PLATE_SCRIPTS_PATH/scripts/setup.fish

# Run gulp
# set -l globals $PLATE_PACKAGE_ROOT/globals.mjs
# set -l gulpfile $PLATE_PACKAGE_ROOT/config/gulpfile.mjs
# set -l registry $PLATE_PACKAGE_ROOT/loaders/registry.mjs

# node --trace-warnings
#   --import   registry \
#   --import   globals  \
#   --gulpfile gulpfile \
#   $argv
