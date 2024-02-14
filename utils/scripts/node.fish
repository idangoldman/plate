function setup_node --description 'Setup Node environment with fnm and pnpm'
    fnm list-remote | tail -n 1 | string replace v '' >.node-version
    fnm use --install-if-missing --corepack-enabled
    pnpm init
    corepack use pnpm@latest

    # Update node and pnpm versions in package.json
    set node_version (node --version | string replace v '')
    set pnpm_version (pnpm --version)
    jq --arg node_version "$node_version" --arg pnpm_version "$pnpm_version" \
        '.version = 0.0.1 | .engines.node = $node_version | .engines.pnpm = $pnpm_version' \
        package.json >package.tmp.json
    mv package.tmp.json package.json

    # Install core dependencies
    pnpm add --save-dev browser-sync coffeescript del gulp gulp-cli js-yaml gulp-coffee gulp-stylus plugin-error zx
end
