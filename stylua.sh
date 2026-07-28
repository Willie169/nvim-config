#!/bin/bash
for f in $(git ls-files | grep -E '^.*\.lua$'); do
    stylua "$f"
done
