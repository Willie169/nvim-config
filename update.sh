#!/usr/bin/env bash

cwd="$(pwd)"
cd ~/.config/nvim
git reset --hard
git pull --rebase
git clean -fd
cd vim-config
git reset --hard
git pull --rebase
git clean -fd
# shellcheck disable=2164
cd "$cwd"
[ "${1:-}" = '-i' ] || echo "Updated successfully!"
