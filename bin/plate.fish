#!/usr/bin/env fish

# Package setup of fish shell environment
set --global --export PLATE_PKG (realpath (dirname (status --current-filename))/..)
set --global --export PLATE_ROOT (pwd -P)

set --local registry_path $PLATE_PKG/imports/registry.mjs

node \
    --trace-warnings \
    --import $registry_path \
    $argv
