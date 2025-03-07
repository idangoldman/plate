#!/usr/bin/env fish

# PLATE Framework Help Script
# Provides formatted help information about available commands

function print_header
    set_color blue
    echo ""
    echo "PLATE Framework CLI"
    echo "==================="
    set_color normal
    echo ""
    echo "A web development framework built on principles of joy and readability."
    echo ""
end

function print_usage
    set_color yellow
    echo "Usage:"
    set_color normal
    echo "  plate [pkg] <command> [arguments...]"
    echo ""
    echo "  pkg             - Run command in the package context (default is project context)"
    echo "  command         - The command to execute (see categories below)"
    echo "  arguments       - Command-specific arguments"
    echo ""
end

function print_footer
    echo ""
    set_color blue
    echo "For more information, visit: https://github.com/idangoldman/plate/"
    set_color normal
    echo ""
end

function get_description
    set -l file $argv[1]
    set -l process $argv[2]

    # Extract description from the process-compose yml file
    set description (yq eval ".processes.$process.description" $file 2>/dev/null)

    # If description is null or not found, return a default
    if test "$description" = null -o -z "$description"
        echo "No description available"
    else
        echo $description
    end
end

function print_commands
    set -l arg $argv[1]
    set -l compose_files

    # Check if we received arguments
    if test -n "$arg"
        # Check if argument is a directory
        if test -d "$arg"
            # Get all YAML files from the provided directory
            for file in "$arg/"*.yml
                if test -f "$file"
                    set -a compose_files "$file"
                end
            end
        else
            # If not a directory, treat arguments as files
            for file in $argv
                if test -f "$file"
                    set -a compose_files "$file"
                end
            end
        end
    end

    # If no files found, try default location
    if test (count $compose_files) -lt 1 && set -q PLATE_PKG_PATH
        for file in "$PLATE_PKG_PATH/processes/"*.yml
            if test -f "$file"
                set -a compose_files "$file"
            end
        end
    end

    if test (count $compose_files) -lt 1
        set_color red
        echo "Error: No process-compose files found!"
        set_color normal
        return 1
    end

    # Process each file individually and collect namespaces with commands
    set -l namespaces
    set -l namespace_commands

    for file in $compose_files
        # Get all processes from this file
        set -l processes (yq '.processes | keys | .[]' $file 2>/dev/null)

        for process in $processes
            # Get namespace for this process (default if not specified)
            set -l namespace (yq ".processes.$process.namespace // \"default\"" $file 2>/dev/null)
            set -l description (yq ".processes.$process.description // \"No description\"" $file 2>/dev/null)

            # If namespace doesn't exist in our array yet, add it
            if not contains -- $namespace $namespaces
                set -a namespaces $namespace
            end

            # Store the command info using a separator that's unlikely to appear in names
            set -a namespace_commands "$namespace|||$process|||$description|||$file"
        end
    end

    # Display the formatted output by namespace
    if test (count $namespace_commands) -gt 0
        echo "Available commands:"
        echo ""

        # Sort namespaces alphabetically
        for namespace in (printf '%s\n' $namespaces | sort)
            set_color green
            echo "$namespace:"
            set_color normal

            # Find all commands for this namespace and sort them
            set -l commands_for_namespace
            for cmd_info in $namespace_commands
                set -l parts (string split "|||" $cmd_info)
                if test "$parts[1]" = "$namespace"
                    set -a commands_for_namespace "$parts[2]|$parts[3]"
                end
            end

            # Display sorted commands with their descriptions
            for sorted_cmd in (printf '%s\n' $commands_for_namespace | sort)
                set -l cmd_parts (string split "|" $sorted_cmd)
                printf "  %-20s %s\n" $cmd_parts[1] $cmd_parts[2]
            end

            echo ""
        end
    else
        set_color red
        echo "Error: No commands found in the process-compose files."
        set_color normal
    end
end

# Main script execution
print_header
print_usage

if test (count $argv) -ge 1
    print_commands $argv
else
    # Use default process-compose files in PLATE_PKG_PATH if available
    if set -q PLATE_PKG_PATH
        set default_files "$PLATE_PKG_PATH/processes/"*.yml
        print_commands $default_files
    else
        set_color red
        echo "Error: PLATE_PKG_PATH environment variable is not set!"
        echo "Please run this script through the 'plate' command or set the environment variable manually."
        set_color normal
        exit 1
    end
end

print_footer
