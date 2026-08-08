vim.cmd("source ~/.config/nvim/vim-config/basic.vim")
local undodir = vim.fn.stdpath("state") .. "/undodir"
vim.fn.mkdir(undodir, "p")
vim.opt.undodir = undodir
vim.opt.undofile = true
require("config.lazy")
require("config.lsp")
pcall(require, "config.my_configs")
