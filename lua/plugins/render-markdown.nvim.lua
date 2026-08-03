return {
	"MeanderingProgrammer/render-markdown.nvim",
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
