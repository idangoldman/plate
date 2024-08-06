#!/usr/bin/env fish

# Package setup of fish shell environment
set --global --export PLATE_PKG (find_parent_folder (status --current-filename) plate)
set --global --export PLATE_NODE_MODULES (find_parent_folder $PLATE_PKG node_modules)
set --global --export PLATE_PRJ (pwd -P)

set --local registry_path $PLATE_PKG/imports/registry.mjs
set --local node_arguments ""

for argument in $argv
    if test $argument = locals
        set argument $PLATE_PKG"bin/$argument.js"
    end

    set --append node_arguments $argument
end

echo $node_arguments

# node --trace-warnings --import $registry_path $node_arguments
