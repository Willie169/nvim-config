#!/bin/bash
echo '*
!.gitignore' > lua/plugins/.gitignore
for f in $(ls lua/plugins); do
    echo '!'"$f" >> lua/plugins/.gitignore
done
for f in $(git ls-files | grep -E '^.*\.lua$'); do
    stylua "$f"
done
