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
			shfmt = {
				append_args = { "-i", "2", "-ci" },
			},
			autopep8 = {
				append_args = { "--aggressive", "--aggressive" },
			},
		},
		formatters_by_ft = {
			c = { "clang-format" },
			cpp = { "clang-format" },
			java = { "clang-format" },
			css = { "prettier" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			json = { "prettier" },
			yaml = { "prettier" },
			sh = { "shfmt" },
			rust = { "rustfmt" },
			lua = { "stylua" },
			python = { "autopep8" },
		},
		format_on_save = {
			timeout_ms = 3000,
			lsp_format = "fallback",
		},
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
