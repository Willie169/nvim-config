return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason.nvim",
			{ "mason-org/mason-lspconfig.nvim", config = function() end },
		},
		opts_extend = { "servers.*.keys" },
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
