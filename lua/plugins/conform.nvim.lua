return {
	"stevearc/conform.nvim",
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format()
			end,
			mode = { "n", "x" },
			desc = "Format",
		},
	},
	config = function()
		require("conform").setup({
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
				html = { "prettier" },
				markdown = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				sh = { "shfmt" },
				rust = { "rustfmt" },
				lua = { "stylua" },
				python = { "autopep8" },
			},
			format_on_save = {
				timeout_ms = 1000,
				lsp_format = "fallback",
			},
		})
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
