#!/usr/bin/fish

function find_package_path --argument path
    set -l current_path $path

    while test -n $current_path
        if test -e $current_path/package.json
            echo $current_path
            return
        end
        set -l current_path (dirname $current_path)
    end

    echo "Node package root directory not found" >&2
    exit 1
end
