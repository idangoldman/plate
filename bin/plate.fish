#!/usr/bin/env fish

# Package setup of fish shell environment
set --global --export PLATE_PKG_PATH (find_parent_folder (status --current-filename) plate)
set --global --export PLATE_PRJ_PATH (pwd -P)

node \
    --trace-warnings \
    --trace-deprecation \
    --trace-uncaught \
    --import="$PLATE_PKG_PATH/src/registry.js" \
    $argv
