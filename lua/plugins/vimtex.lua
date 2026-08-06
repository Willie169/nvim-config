return {
	"lervag/vimtex",
	lazy = false,
	config = function()
		vim.g.vimtex_compiler_enabled = vim.fn.executable("latexmk") == 1 and 1 or 0
		vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"
	end,
	keys = {
		{ "<localLeader>l", "", desc = "+vimtex", ft = "tex" },
		{
			"<localleader>lt",
			function()
				return require("vimtex.fzf-lua").run()
			end,
			desc = "vimtex fzf-lua",
		},
	},
}
