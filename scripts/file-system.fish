#!/usr/bin/fish

set -l current_dir (pwd)
set -l project_dir $argv[1]

function create_directories --description 'Create project directories'
    mkdir -p assets config scripts styles tasks templates tmp utils
end

function create_files --description 'Create initial project files'
    touch config/environment.yml
    touch scripts/script.coffee
    touch styles/style.styl
    touch tasks/task.coffee
    touch templates/index.slim
    touch tmp/.keep
    touch README.md
end

function copy_template_files --description 'Copy project initial files'
    cp -rv $current_dir/config $current_dir/.editorconfig $current_dir/.gitignore \
        $current_dir/LICENSE.txt $current_dir/README.md \
        $project_dir
end
