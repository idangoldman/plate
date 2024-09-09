#!/usr/bin/env fish

# Remove this line after having the same global node and pnpm versions
if type -q fnm
    fnm use --resolve-engines --corepack-enabled --install-if-missing --silent-if-unchanged --log-level=quiet
end

# Load the plate environment variables
if test -z "$PLATE_ENV"
    set --global --export PLATE_ENV development
end

set --global --export PLATE_PKG_PATH (find_parent_folder (status --current-filename) plate)
set --global --export PLATE_PRJ_PATH (pwd -P)

set --global --export PLATE_BIN_PATH $PLATE_PKG_PATH/node_modules/.bin
set --global --export PLATE_CONF_PATH .(string replace --regex --ignore-case $PLATE_PRJ_PATH "" $PLATE_PKG_PATH)/configs

set --global --export PLATE_CLI_COMMAND help
set --global --export PLATE_CLI_ARGS $argv[2..-1]

# Check for the pkg command, setting project as package target
if test (count $argv) -ge 1
    set --local command_index 1

    if test $argv[$command_index] = pkg
        set --global --export PLATE_PRJ_PATH $PLATE_PKG_PATH
        set command_index 2
    end

    set --global --export PLATE_CLI_COMMAND $argv[$command_index]
    set --global --export PLATE_CLI_ARGS $argv[$command_index..-1]
end

echo "PLATE_ENV: $PLATE_ENV"
echo "PLATE_PKG_PATH: $PLATE_PKG_PATH"
echo "PLATE_PRJ_PATH: $PLATE_PRJ_PATH"
echo "PLATE_BIN_PATH: $PLATE_BIN_PATH"
echo "PLATE_CONF_PATH: $PLATE_CONF_PATH"
echo "PLATE_CLI_COMMAND: $PLATE_CLI_COMMAND"
echo "PLATE_CLI_ARGS: $PLATE_CLI_ARGS"
echo "PLATE_PRJ_PATH: $PLATE_PRJ_PATH"
echo "PLATE_CLI_COMMAND: $PLATE_CLI_COMMAND"
echo "PLATE_CLI_ARGS: $PLATE_CLI_ARGS"

make --debug --makefile $PLATE_PKG_PATH/Makefile $PLATE_CLI_COMMAND
