#!/usr/bin/env fish

if test -z "$PLATE_ENV"
    set --global --export PLATE_ENV development
end

set --global --export PLATE_PKG_PATH (find_parent_folder (status --current-filename) plate)
set --global --export PLATE_PRJ_PATH (pwd -P)/

set --global --export PLATE_BIN_PATH $PLATE_PKG_PATH/node_modules/.bin
set --global --export PLATE_CONF_PATH $PLATE_PKG_PATH/configs

set --global --export PLATE_CLI_COMMAND help
set --global --export PLATE_CLI_ARGS $argv[2..-1]

if test (count $argv) -ge 1
    set --global --export PLATE_CLI_COMMAND $argv[1]
end

make --makefile $PLATE_PKG_PATH/Makefile $PLATE_CLI_COMMAND
