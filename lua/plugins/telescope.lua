return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = (build_cmd ~= "cmake") and "make"
					or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
				enabled = build_cmd ~= nil,
			},
		},
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
			vim.keymap.set("n", "<leader>dg", builtin.diagnostics, { desc = "Telescope diagnostics" })
			vim.keymap.set("n", "<leader>ip", builtin.lsp_implementations, { desc = "Telescope lsp implementations" })
			vim.keymap.set("n", "<leader>df", builtin.lsp_definitions, { desc = "Telescope lsp implementations" })
			vim.keymap.set(
				"n",
				"<leader>tdf",
				builtin.lsp_type_definitions,
				{ desc = "Telescope lsp type implementations" }
			)
			vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Telescope git commits" })
			vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Telescope git branches" })
			vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Telescope git status" })
			vim.keymap.set("n", "<leader>gh", builtin.git_stash, { desc = "Telescope git stash" })
			vim.keymap.set("n", "<leader>tr", builtin.treesitter, { desc = "Telescope treesitter" })
		end,
	},
}
