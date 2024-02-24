#!/usr/bin/env fish

# Package setup of fish shell environment
set -gx PLATE_PKG (realpath (dirname (status --current-filename))/..)
source $PLATE_PKG/scripts/setup.fish

# Run gulp
set -l globals  $PLATE_PKG/utils/globals.mjs
set -l gulp_bin $PLATE_PKG/node_modules/gulp/bin/gulp.js
set -l gulpfile $PLATE_PKG/config/gulpfile.mjs
set -l registry $PLATE_PKG/loaders/registry.mjs

node --trace-warnings --import $registry --import $globals $gulp_bin --gulpfile $gulpfile $argv
