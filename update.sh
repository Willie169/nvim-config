#!/usr/bin/env bash

cwd="$(pwd)"
cd ~/.config/nvim || exit
git reset --hard
git pull --rebase
git clean -fd
cd vim-config || exit
git reset --hard
git pull --rebase
git clean -fd
# shellcheck disable=2164
cd "$cwd"
[ "${1:-}" = '-i' ] || echo "Updated successfully!"
