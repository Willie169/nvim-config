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
			vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Telescope git commits" })
			vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Telescope git branches" })
			vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Telescope git status" })
			vim.keymap.set("n", "<leader>gh", builtin.git_stash, { desc = "Telescope git stash" })
			vim.keymap.set("n", "<leader>uy", builtin.registers, { desc = "Telescope registers" })
			vim.keymap.set("n", "<leader>u/", builtin.search_history, { desc = "Telescope search history" })
			vim.keymap.set("n", "<leader>ua", builtin.autocommands, { desc = "Telescope autocommands" })
			vim.keymap.set(
				"n",
				"<leader>ub",
				builtin.current_buffer_fuzzy_find,
				{ desc = "Telescope current buffer fuzzy find" }
			)
			vim.keymap.set("n", "<leader>uc", builtin.command_history, { desc = "Telescope command history" })
			vim.keymap.set("n", "<leader>uC", builtin.commands, { desc = "Telescope commands" })
			vim.keymap.set("n", "<leader>ud", builtin.diagnostics, { desc = "Telescope diagnostics" })
			vim.keymap.set("n", "<leader>uh", builtin.highlights, { desc = "Telescope highlights" })
			vim.keymap.set("n", "<leader>uj", builtin.jumplist, { desc = "Telescope jumplist" })
			vim.keymap.set("n", "<leader>uk", builtin.keymaps, { desc = "Telescope keymaps" })
			vim.keymap.set("n", "<leader>ul", builtin.loclist, { desc = "Telescope loclist" })
			vim.keymap.set("n", "<leader>uM", builtin.man_pages, { desc = "Telescope man pages" })
			vim.keymap.set("n", "<leader>um", builtin.marks, { desc = "Telescope marks" })
			vim.keymap.set("n", "<leader>uo", builtin.vim_options, { desc = "Telescope vim options" })
			vim.keymap.set("n", "<leader>ur", builtin.resume, { desc = "Telescope resume" })
			vim.keymap.set("n", "<leader>uq", builtin.quickfix, { desc = "Telescope quickfix" })
			vim.keymap.set("n", "<leader>tr", builtin.treesitter, { desc = "Telescope treesitter" })
			vim.api.nvim_create_user_command("T", "Telescope <args>", {
				nargs = "*",
			})
		end,
	},
}
