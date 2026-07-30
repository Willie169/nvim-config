#!/usr/bin/env bash

set -e
rm -rf ~/.local/share/nvim || true
rm -rf ~/.local/state/nvim || true
rm -rf ~/.cache/nvim || true
rm -rf ~/.config/nvim || true
mkdir -p ~/.config
git clone --depth=1 https://github.com/Willie169/nvim-config.git ~/.config/nvim
cd ~/.config/nvim
mkdir -p ~/.vim_undodir
wget https://raw.githubusercontent.com/Willie169/vim-config/refs/heads/main/basic.vim
echo "Installed successfully!"
