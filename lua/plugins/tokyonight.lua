return {
	{
		"folke/tokyonight.nvim",
		opts = {
			styles = {
				comments = { italic = false },
			},
		},
		config = function()
			vim.cmd([[colorscheme tokyonight-moon]])
		end,
	},
}
