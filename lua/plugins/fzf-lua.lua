vim.api.nvim_create_user_command("F", "FzfLua <args>", {
	nargs = "*",
})

return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-mini/mini.icons" },
	lazy = false,
	config = function()
		require("fzf-lua").setup({ "telescope", "border-fused" })
	end,
	keys = {
		-- find
		{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Files" },
		{ "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers (sorted)" },
		{ "<leader>fB", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
		{ "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
		{ "<leader>fl", "<cmd>FzfLua live_grep<cr>", desc = "Live Grep" },
		{ "<leader>fg", "<cmd>FzfLua live_grep_glob<cr>", desc = "Live Grep (glob)" },
		{ "<leader>ft", "<cmd>FzfLua treesitter<cr>", desc = "Treesitter" },
		-- git
		{ "<leader>gf", "<cmd>FzfLua git_files<cr>", desc = "Git Files" },
		{ "<leader>gb", "<cmd>FzfLua git_branches<cr>", desc = "Git Branches" },
		{ "<leader>gc", "<cmd>FzfLua git_commits<cr>", desc = "Git Commits" },
		{ "<leader>gl", "<cmd>FzfLua git_bcommits<cr>", desc = "Git Buffer Commits" },
		{ "<leader>gd", "<cmd>FzfLua git_diff<cr>", desc = "Git Diff" },
		{ "<leader>gs", "<cmd>FzfLua git_status<cr>", desc = "Git Status" },
		{ "<leader>gh", "<cmd>FzfLua git_stash<cr>", desc = "Git Stash" },
		{ "<leader>gw", "<cmd>FzfLua git_worktrees<cr>", desc = "Git Worktrees" },
		-- search
		{ "<leader>uy", "<cmd>FzfLua registers<cr>", desc = "Registers" },
		{ "<leader>u/", "<cmd>FzfLua search_history<cr>", desc = "Search History" },
		{ "<leader>ua", "<cmd>FzfLua autocmds<cr>", desc = "Auto Commands" },
		{ "<leader>ub", "<cmd>FzfLua lines<cr>", desc = "Buffer Lines" },
		{ "<leader>uc", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
		{ "<leader>uC", "<cmd>FzfLua commands<cr>", desc = "Commands" },
		{ "<leader>ud", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Diagnostics" },
		{ "<leader>uD", "<cmd>FzfLua diagnostics_document<cr>", desc = "Buffer Diagnostics" },
		{ "<leader>uh", "<cmd>FzfLua highlights<cr>", desc = "Search Highlight Groups" },
		{ "<leader>uj", "<cmd>FzfLua jumps<cr>", desc = "Jumplist" },
		{ "<leader>uk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
		{ "<leader>ul", "<cmd>FzfLua loclist<cr>", desc = "Location List" },
		{ "<leader>uM", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },
		{ "<leader>um", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
		{ "<leader>ur", "<cmd>FzfLua resume<cr>", desc = "Resume" },
		{ "<leader>uq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
		{ "<leader>us", "<cmd>FzfLua spellcheck<cr>", desc = "Spellcheck List" },
		{ "<leader>uu", "<cmd>FzfLua undotree<cr>", desc = "Undo Tree" },
		-- lsp
		{ "<leader>li", "<cmd>FzfLua lsp_implementations<cr>", desc = "LSP Implementations" },
		{ "<leader>ld", "<cmd>FzfLua lsp_definions<cr>", desc = "LSP Definitions" },
		{ "<leader>lg", "<cmd>FzfLua lsp_document_diagnostics<cr>", desc = "LSP Document Diagnostics" },
		{ "<leader>ls", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "LSP Document Symbols" },
		{ "<leader>lc", "<cmd>FzfLua lsp_declarations<cr>", desc = "LSP Declareations" },
		{ "<leader>lt", "<cmd>FzfLua lsp_typedefs<cr>", desc = "LSP Type Definitions" },
		{ "<leader>lr", "<cmd>FzfLua lsp_references<cr>", desc = "LSP References" },
	},
}
