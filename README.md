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

