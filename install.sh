#!/bin/sh
set -e

mkdir -p ~/.config
git clone --depth=1 https://github.com/Willie169/nvim-config.git ~/.config/nvim
cd ~/.config/nvim
wget https://raw.githubusercontent.com/Willie169/vim-config/refs/heads/main/basic.vim
echo "Installed successfully!"

