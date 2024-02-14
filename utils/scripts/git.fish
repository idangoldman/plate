function initial_commit --description 'Make initial Git commit'
    git add .
    git commit -m 'Initial commit'
    git push -u origin main --force
end
