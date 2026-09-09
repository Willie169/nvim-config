return {
	"saghen/blink.cmp",
	dependencies = { "saghen/blink.lib", "L3MON4D3/LuaSnip", "Kaiser-Yang/blink-cmp-dictionary" },
	lazy = false,
	build = function()
		require("blink.cmp").build():pwait()
	end,
	opts = {
		keymap = { preset = "super-tab" },
		completion = {
			keyword = { range = "full" },
			documentation = { auto_show = true, auto_show_delay_ms = 500 },
			ghost_text = { enabled = true },
		},
		snippets = {
			preset = "luasnip",
		},
		sources = {
			default = { "dictionary", "lsp", "path", "snippets", "buffer" },
			providers = {
				dictionary = {
					module = "blink-cmp-dictionary",
					name = "Dict",
					min_keyword_length = 1,
					opt = {
						dictionary_directories = { vim.fn.expand("~/.config/nvim/dictionary") },
					},
				},
			},
		},
		fuzzy = { implementation = "rust" },
	},
}
