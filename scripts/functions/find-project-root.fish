#!/usr/bin/fish

function find_project_root --argument path
    set -l parts (string split -m 1 'node_modules' -- $path)

    if set -q parts[1]
        echo $parts[1]
        return
    end

    find_package_root $path
end
