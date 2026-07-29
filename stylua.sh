#!/bin/bash
shopt -s globstar
echo '*
!.gitignore' > lua/plugins/.gitignore
for f in $(ls lua/plugins); do
    echo '!'"$f" >> lua/plugins/.gitignore
done
for f in $(ls **/*.lua); do
    stylua "$f"
done
