require("config.lazy")
vim.cmd("source basic.vim")
pcall(require, "config.my_configs")
