require("config.lazy")
vim.cmd("source vim-config/basic.vim")
pcall(require, "config.my_configs")
