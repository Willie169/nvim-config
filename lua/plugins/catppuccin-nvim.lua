vim.cmd.colorscheme("catppuccin-nvim")

return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	opts = {
		flavour = "mocha",
		transparent_background = true,
		float = { transparent = true },
	},
}
