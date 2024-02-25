#!/usr/bin/env fish

# Package setup of fish shell environment
set -gx PLATE_PKG (realpath (dirname (status --current-filename))/..)
set -gx PLATE_ROOT (pwd -P)

# Run gulp
set -l gulp_bin $PLATE_PKG/../gulp/bin/gulp.js
set -l gulp_file $PLATE_PKG/configs/gulpfile.mjs
set -l registry $PLATE_PKG/imports/registry.mjs

node --trace-warnings \
  --import $registry \
  $gulp_bin \
    --cwd $PLATE_ROOT \
    --gulpfile $gulp_file \
    $argv
