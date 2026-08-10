return {
	"Willie169/match-delimiter.nvim",
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },
	config = function()
		require("match-delimiter").setup()
	end,
}
