return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			integrations = {
				grug_far = true,
				lsp_trouble = true,
				which_key = true,
			},
		})
		vim.cmd.colorscheme("catppuccin-nvim")
	end,
}
