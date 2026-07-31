return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers,
			{
				["*"] = {
					keys = {
						{
							"gd",
							function()
								require("telescope.builtin").lsp_definitions({ reuse_win = true })
							end,
							desc = "Goto Definition",
							has = "definition",
						},
						{ "gr", "<cmd>Telescope lsp_references<cr>", desc = "References", nowait = true },
						{
							"gI",
							function()
								require("telescope.builtin").lsp_implementations({ reuse_win = true })
							end,
							desc = "Goto Implementation",
						},
						{
							"gy",
							function()
								require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
							end,
							desc = "Goto T[y]pe Definition",
						},
					},
				},
			},
		},
	},
}
