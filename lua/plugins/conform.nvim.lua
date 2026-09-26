return {
	"stevearc/conform.nvim",
	lazy = false,
	keys = {
		{
			"<localleader>f",
			function()
				require("conform").format()
			end,
			mode = { "n", "x" },
			desc = "Format",
		},
	},
	opts = {
		default_format_opts = {
			timeout_ms = 3000,
			async = false,
			quiet = false,
			lsp_format = "fallback",
		},
		formatters = {
			["clang-format"] = {
				append_args = { "-style=llvm" },
			},
			latexindent = {
				append_args = { "-g", "/dev/null" },
			},
			shfmt = {
				append_args = { "-i", "2", "-ci" },
			},
		},
		formatters_by_ft = {
			c = { "clang-format" },
			cpp = { "clang-format" },
			css = { "prettier" },
			java = { "clang-format" },
			javascript = { "prettier" },
			json = { "prettier" },
			latex = { "latexindent" },
			lua = { "stylua" },
			python = { "black" },
			rust = { "rustfmt" },
			sh = { "shfmt" },
			typescript = { "prettier" },
			yaml = { "prettier" },
		},
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
