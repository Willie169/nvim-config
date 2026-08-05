return {
	"folke/flash.nvim",
	vscode = true,
	keys = {
		{
			"sj",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
		{
			"st",
			mode = { "n", "o", "x" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
		{
			"sr",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Remote Flash",
		},
		{
			"ss",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Treesitter Search",
		},
		{
			"<c-s>",
			mode = { "c" },
			function()
				require("flash").toggle()
			end,
			desc = "Toggle Flash Search",
		},
		-- Simulate nvim-treesitter incremental selection
		{
			"s<space>",
			mode = { "n", "o", "x" },
			function()
				require("flash").treesitter({
					actions = {
						["<CR>"] = "next",
						["<BS>"] = "prev",
					},
				})
			end,
			desc = "Treesitter Incremental Selection",
		},
	},
}
