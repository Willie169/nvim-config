vim.cmd("source ~/.config/nvim/basic.vim")
require("config.lazy")
pcall(require, "config.my_configs")
