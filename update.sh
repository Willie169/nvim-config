#!/bin/sh
set -e

cd ~/.config/nvim
git reset --hard
git submodule deinit --all --force
git pull --rebase
git submodule sync --recursive
git submodule update --init --remote --recursive
git clean -fd
rm basic.vim || true
wget https://raw.githubusercontent.com/Willie169/vim-config/refs/heads/main/basic.vim
echo "Updated successfully!"

