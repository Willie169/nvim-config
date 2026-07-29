return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason.nvim",
			{ "mason-org/mason-lspconfig.nvim", config = function() end },
		},
		keys = {
			{ "gd", vim.lsp.buf.definition, desc = "Goto Definition" },
			{ "gr", vim.lsp.buf.references, desc = "References" },
			{ "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
			{ "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
			{ "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
		},
	},
}
