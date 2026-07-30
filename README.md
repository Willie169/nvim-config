## nvim-config

My configuration for Neovim 0.12.0 or later. Part of it is derived from [LazyVim](https://github.com/LazyVim/LazyVim).

### Installation

Backp your configurations first.
```
curl -fsSL https://raw.githubusercontent.com/Willie169/nvim-config/refs/heads/main/install.sh | sh
```

### Update

```
sh ~/.config/nvim/update.sh
```

### Customization

After you have installed the setup, put your customization in `~/.config/nvim/lua/config/my_configs.lua` and plugins in `~/.config/nvim/lua/plugins/`.

### Included Plugins

* [fcitx.vim](https://github.com/lilydjwg/fcitx.vim): Keep and restore fcitx state for each buffer separately when leaving/re-entering insert mode or search mode
* [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter): Nvim Treesitter configurations and abstraction layer

### Vim

Refer to my [vim-config](https://github.com/Willie169/nvim-config) repo for my Vim configuration.

