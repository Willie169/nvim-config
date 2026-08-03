return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "ibhagwan/fzf-lua" },
	opts = {},
	keys = {
		{
			"]t",
			function()
				require("todo-comments").jump_next()
			end,
			desc = "Next Todo Comment",
		},
		{
			"[t",
			function()
				require("todo-comments").jump_prev()
			end,
			desc = "Previous Todo Comment",
		},
		{ "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
		{ "<leader>st", "<cmd>TodoFzfLua<cr>", desc = "Todo" },
	},
}
