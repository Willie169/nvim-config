## nvim-config

My configuration for Neovim 0.12.0 or later. Part of it is derived from [LazyVim](https://github.com/LazyVim/LazyVim).

### Configuration Installation

Backp your configurations first.
```
curl -fsSL https://raw.githubusercontent.com/Willie169/nvim-config/refs/heads/main/install.sh | sh
```

### Full Installation

Backp your configurations first.
```
curl -fsSL https://raw.githubusercontent.com/Willie169/nvim-config/refs/heads/main/full-install.sh | bash
```
This script will add following line to your `"$HOME/.bashrc"`:
```
export PATH="${HOME}/.cargo/bin:${HOME}/eclipse.jdt.ls/bin:${HOME}/ktlsp/server/bin:${HOME}/.local/bin:${PATH}"
```
If you don't want it to touch your `"$HOME/.bashrc"`, use
```
curl -fsSL https://raw.githubusercontent.com/Willie169/nvim-config/refs/heads/main/full-install.sh | bash -s -- -n
```

Full installation installs
- [Neovim](https://github.com/neovim/neovim)
- [Pynvim](https://github.com/neovim/pynvim)
- [Neovim node.js client](https://github.com/neovim/node-client)
- [shellcheck](https://github.com/koalaman/shellcheck)
- [yazi](https://github.com/sxyazi/yazi)
- [ripgrep](https://github.com/burntsushi/ripgrep)
- [fzf](https://github.com/junegunn/fzf)
- [Jupytext](https://github.com/jupytext/jupytext)
- [bash-language-server](https://github.com/bash-lsp/bash-language-server)
- [clangd](https://github.com/llvm/llvm-project/tree/main/clang-tools-extra/clangd)
- [cmake-language-server](https://github.com/regen100/cmake-language-server)
- [dockerfile-language-server-nodejs](https://github.com/rcjsuen/dockerfile-language-server)
- [eclipse.jdt.ls](https://github.com/eclipse-jdtls/eclipse.jdt.ls)
- [gopls](https://github.com/golang/tools/tree/master/gopls)
- [ktlsp](https://codeberg.org/winlogon/ktlsp)
- [lua-language-server](https://github.com/LuaLS/lua-language-server)
- [marksman](https://github.com/artempyanykh/marksman)
- [perl-lsp](https://github.com/FractalBoy/perl-language-server)
- [pyright](https://github.com/microsoft/pyright)
- [quick-lint-js](https://github.com/quick-lint/quick-lint-js)
- [ra_ap_rust-analyzer](https://github.com/rust-lang/rust-analyzer)
- [superhtml](https://github.com/kristoff-it/superhtml)
- [texlab](https://github.com/latex-lsp/texlab)
- [verible](https://github.com/chipsalliance/verible)
- [vscode-json-languageserver](https://github.com/microsoft/vscode-json-languageservice)
- [yaml-language-server](https://github.com/redhat-developer/yaml-language-server)
and installs Neovim configuration from this repo.

Debian derivatives on x86\_64 or AArch64 architecture with normal or root user are supported provided that the following executables are available:
- `apt`
- `brew`: can be installed with:
  ```
  [ "$EUID" -eq 0 ] && touch /.dockerenv
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
  ```
- `cargo`: can be installed with:
  ```
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  . "${HOME}"/.cargo/env
  ```
- `cargo-binstall`: can be installed with:
  ```
  curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
  ```
- `npm`: can be installed with:
  ```
  NVM_VERSION=$(curl -fsSL "https://api.github.com/repos/nvm-sh/nvm/releases/latest" | jq -r '.tag_name')
  bash -c "curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash"
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
  nvm install --lts
  echo y | corepack enable npm
  echo y | npm --help || true
  ```
- `uv`: can be installed with:
  ```
  curl -LsSf https://astral.sh/uv/install.sh | sh
  ```

Termux is supported provided that the following executables are available:
- `apt`
- `cargo`: can be installed with:
  ```
  pkg install rust -y
  ```
- `npm`: can be installed with:
  ```
  pkg install nodejs-lts npm -y
  ```
- `pkg`
- `uv`: can be installed with:
  ```
  pkg install uv -y
  ```

Run `:checkhealth` in Neovim after installation and refer to the documentations of the plugins for other optional external software you may install.

This is also used in my [**ubuntu-setup-with-vnc-and-gpu**](https://github.com/Willie169/ubuntu-setup-with-vnc-and-gpu) and [**termux-sh**](https://github.com/Willie169/termux-sh) repos. You may check them out for my full setup.

### Configuration Update

```
sh ~/.config/nvim/update.sh
```

### Full Update

Full update updates all applications installed in full installation that is not managed by a package manager, including those installed with `cargo` and `cargo-binstall`, and updates Neovim configuration.
```
bash ~/.config/nvim/full-update.sh
```

### Customization

After you have installed the setup, put your customization in `~/.config/nvim/lua/config/my_configs.lua` and plugins in `~/.config/nvim/lua/plugins/`.

### Included Plugins

* [blink.cmp](https://github.com/saghen/blink.cmp)
* [bufferline.nvim](https://github.com/akinsho/bufferline.nvim)
* [fcitx.vim](https://github.com/lilydjwg/fcitx.vim)
* [flash.nvim](https://github.com/folke/flash.nvim)
* [fzf-lua](https://github.com/ibhagwan/fzf-lua)
* [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
* [grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim)
* [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
* [jupytext.nvim](https://github.com/goerz/jupytext.nvim)
* [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
* [mini.ai](https://github.com/nvim-mini/mini.ai)
* [mini.comment](https://github.com/nvim-mini/mini.comment)
* [mini.icons](https://github.com/nvim-mini/mini.icons)
* [mini.pairs](https://github.com/nvim-mini/mini.pairs)
* [mini.surround](https://github.com/nvim-mini/mini.surround)
* [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
* [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
* [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
* [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag)
* [nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring)
* [persistence.nvim](https://github.com/folke/persistence.nvim)
* [vim-suda](https://github.com/lambdalisue/vim-suda)
* [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
* [which-key.nvim](https://github.com/folke/which-key.nvim)
* [yazi.nvim](https://github.com/mikavilpas/yazi.nvim)

<!-- TODO: -->

### Vim

Refer to my [vim-config](https://github.com/Willie169/nvim-config) repo for my Vim configuration.

