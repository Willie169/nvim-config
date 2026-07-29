return {
	{
		"nvim-mini/mini.pairs",
		version = false,
		event = "VeryLazy",
		opts = {
			modes = { insert = true, command = true, terminal = false },
			skip_ts = { "string" },
			skip_unbalanced = true,
			markdown = true,
		},
	},
}
