#!/usr/bin/fish

function find_root_path --argument path
    set -l separator node_modules

    if string match --quiet --regex --ignore-case $separator $path
        echo (string split -m 1 $separator -- $path)[1]
        return
    end

    find_package_path $path
end
