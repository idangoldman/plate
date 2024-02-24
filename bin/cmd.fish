#!/usr/bin/env fish

# Set up package fish shell environment
source ../scripts/setup.fish

# Run gulp
set -l globals $PLATE_PACKAGE_ROOT/globals.mjs
set -l gulpfile $PLATE_PACKAGE_ROOT/config/gulpfile.mjs
set -l registry $PLATE_PACKAGE_ROOT/loaders/registry.mjs

node --trace-warnings
  --import   registry \
  --import   globals  \
  --gulpfile gulpfile \
  $argv
