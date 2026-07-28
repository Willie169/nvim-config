vim.cmd("source basic.vim")
require("config.lazy")
pcall(require, "config.my_configs")
