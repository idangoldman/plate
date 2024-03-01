#!/usr/bin/fish

function project_bootstrap --description 'Create a basic project structure'
    # Create directories
    mkdir -p assets config scripts styles tasks templates tmp utils

    # Create files
    touch config/enviroment.yml
    touch scripts/script.coffee
    touch styles/style.styl
    touch tasks/task.coffee
    touch templates/index.slim
    touch tmp/.keep
    touch README.md

    # Copy files
    cp -rv "$DOTFILES_FOLDER/templates/blah-plate/" .

    # Replace placeholders in LICENSE.txt
    # set current_year (date "+%Y")
    # set full_name 'Idan Goldman'
    # sed -i 's/Copyright \(c\) [0-9]\{4\} \[fullname\]/Copyright \(c\) $current_year $full_name/ig' LICENSE.txt

    # Get-install-use, latest Node version
    fnm list-remote | tail -n 1 | string replace v '' >.node-version
    fnm use --install-if-missing --corepack-enabled

    # Create package.json
    pnpm init

    # Use latest pnpm version
    corepack use pnpm@latest
    # pnpm store prune

    # Update node and pnpm versions in package.json
    set node_version (node --version | string replace v '')
    set pnpm_version (pnpm --version)

    jq --arg node_version "$node_version" --arg pnpm_version "$pnpm_version" \
        '.version = 0.0.1 | .engines.node = $node_version | .engines.pnpm = $pnpm_version' \
        package.json >package.tmp.json
    mv package.tmp.json package.json

    # Install core dependencies
    pnpm add --save-dev browser-sync coffeescript del gulp gulp-cli js-yaml gulp-coffee gulp-stylus plugin-error zx

    # Get-install-use, latest Ruby version
    set ruby_version (rbenv install -l | grep -v - | tail -1)
    $ruby_version >.ruby-version
    rbenv install --skip-existing

    # Update Ruby version in Gemfile
    # sed -i '' -e "s/ruby \"[0-9]+\\.[0-9]+\\.[0-9]+\"/ruby \"$ruby_version\"/g" Gemfile

    # Install core dependencies
    gem install bundler
    bundle install

    # Initial commit
    # git init
    # git branch -M main
    git add .
    git commit -m 'Initial commit'
    git push -u origin main --force
end
