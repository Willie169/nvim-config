return {
	"lervag/vimtex",
	lazy = false,
	config = function()
		vim.g.vimtex_mappings_disable = { ["n"] = { "K" } }
		vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"
	end,
	keys = {
		{ "<localLeader>l", "", desc = "+vimtex", ft = "tex" },
	},
}
