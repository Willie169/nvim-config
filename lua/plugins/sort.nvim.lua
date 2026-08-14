return {
	"sQVe/sort.nvim",
	event = "VeryLazy",
	config = function()
		require("sort").setup({
			delimiters = {
				"\n",
				",",
				"|",
				";",
				":",
				"s", -- Space.
				"t", -- Tab.
			},
			natural_sort = false,
			unique = true,
		})
	end,
}
