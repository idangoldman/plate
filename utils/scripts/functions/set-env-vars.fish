#!/usr/bin/fish

function set_env_vars
    if not set -q PLATE_ROOT
        set -l current_path (status --current-filename | string trim)
        set -l cwd_path (pwd)

        set -l root_from_bin (find_project_root $current_path)
        set -l root_from_cwd (find_project_root $cwd_path)

        if test "$root_from_bin" = "$root_from_cwd"
            set -gx PLATE_ROOT "$root_from_bin"
        else
            echo "Error: The script and the current working directory are not in the same project." >&2
            exit 1
        end
    end

    if not set -q PLATE_PACKAGE_ROOT
        set -l current_path (status --current-filename | string trim)
        set -gx PLATE_PACKAGE_ROOT (find_package_root $current_path)
    end
end
