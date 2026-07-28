## nvim-config

My configuration for Neovim.

### Installation

```
mkdir -p ~/.config
git clone --recurse-submodules --depth=1 https://github.com/Willie169/nvim-config.git ~/.config/nvim
```

### Update

```
cd ~/.config/nvim
git reset --hard
git pull --rebase
git submodule sync --recursive
git submodule update --init --remote --recursive
git clean -fd
```

### Customization

After you have installed the setup, put your customization in `~/.config/nvim/lua/config/my_configs.lua` and plugins in `~/.config/nvim/lua/plugins/`.

### Included Plugins

* [fcitx.vim](https://github.com/lilydjwg/fcitx.vim): Keep and restore fcitx state for each buffer separately when leaving/re-entering insert mode or search mode
* [lightline.vim](https://github.com/itchyny/lightline.vim): A light and configurable statusline/tabline plugin for Vim
* [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter): Nvim Treesitter configurations and abstraction layer
* [termux-clipboard](https://github.com/Willie169/termux-clipboard): Integrate Vim '+' register with the Android system clipboard via Termux APIs
* [vim-fugitive](https://github.com/tpope/vim-fugitive): fugitive.vim: A Git wrapper so awesome, it should be illegal

### Vim

Refer to my [vim-config](https://github.com/Willie169/nvim-config) repo for my Vim configuration.

