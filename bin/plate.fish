#!/usr/bin/env fish

# Package setup of fish shell environment
set --global --export PLATE_PKG (find_parent_folder (status --current-filename) plate)
set --global --export PLATE_PRJ (pwd -P)

node \
    --trace-warnings \
    --trace-deprecation \
    --trace-uncaught \
    --import="$PLATE_PKG/imports/registry.mjs" \
    $argv
