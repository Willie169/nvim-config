return {
	"MeanderingProgrammer/render-markdown.nvim",
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },
	opts = {},
	config = function()
		require("render-markdown").setup({
			code = {
				sign = false,
				language_border = " ",
				language_left = "",
				language_right = "",
			},
			heading = {
				sign = false,
				position = "inline",
			},
			latex = { enabled = false },
		})
	end,
}
