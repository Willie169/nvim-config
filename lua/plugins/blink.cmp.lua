return {
	"saghen/blink.cmp",
	dependencies = { "saghen/blink.lib" },
	build = function()
		require("blink.cmp").build():pwait()
	end,
	opts = {
		keymap = { preset = "default" },
		completion = {
			keyword = { range = "full" },
			documentation = { auto_show = true, auto_show_delay_ms = 500 },
			ghost_text = { enabled = true },
		},
		snippets = {
			preset = "luasnip",
		},
		sources = { default = { "lsp", "path", "snippets", "buffer" } },
		fuzzy = { implementation = "rust" },
	},
}
