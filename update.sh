#!/bin/sh
set -e

cd ~/.config/nvim
git reset --hard
git pull --rebase
git clean -fd
rm basic.vim || true
wget https://raw.githubusercontent.com/Willie169/vim-config/refs/heads/main/basic.vim
echo "Updated successfully!"

