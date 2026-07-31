#!/usr/bin/env bash

set -e
cd ~/.config/nvim
git reset --hard
git pull --rebase
git clean -fd
cd vim-config
git reset --hard
git pull --rebase
git clean -fd
echo "Updated successfully!"
