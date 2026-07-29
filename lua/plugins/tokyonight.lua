return {
	{
		"folke/tokyonight.nvim",
		require("tokyonight").setup({
			styles = {
				comments = { italic = false }, -- Disable italics in comments
			},
		}),
		config = function()
			vim.cmd([[colorscheme tokyonight-moon]])
		end,
	},
}
