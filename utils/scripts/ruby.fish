function setup_ruby --description 'Setup Ruby environment with rbenv'
    set ruby_version (rbenv install -l | grep -v - | tail -1)
    echo $ruby_version >.ruby-version
    rbenv install --skip-existing
    gem install bundler
    bundle install
end
