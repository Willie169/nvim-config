return {
	"MagicDuck/grug-far.nvim",
	dependencies = { "nvim-mini/mini.icons" },
	opts = { headerMaxWidth = 80 },
	keys = {
		{
			"<leader>sg",
			function()
				require("grug-far").open()
			end,
			mode = { "n", "x" },
			desc = "grug-far",
		},
		{
			"<leader>sr",
			function()
				local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
				require("grug-far").open({
					transient = true,
					prefills = {
						filesFilter = ext and ext ~= "" and "*." .. ext or nil,
					},
				})
			end,
			mode = { "n", "x" },
			desc = "grug-far in current file type",
		},
		{
			"<leader>sh",
			function()
				local search = vim.fn.getreg("/")
				-- surround with \b if "word" search (such as when pressing `*`)
				if search and vim.startswith(search, "\\<") and vim.endswith(search, "\\>") then
					search = "\\b" .. search:sub(3, -3) .. "\\b"
				elseif search and vim.startswith(search, "\\V") then
					search = search:sub(3)
				end
				local inst = require("grug-far").open({
					prefills = {
						search = search,
					},
				})
				inst:when_ready(function()
					inst:goto_input("replacement")
				end)
			end,
			mode = { "n", "x" },
			desc = "grug-far using @/ or visual selection",
		},
		{
			"<leader>sl",
			function()
				local opts = {}
				local entry = require("grug-far").get_last_history_entry()
				if entry ~= nil then
					opts.prefills = entry
					opts.engine = entry.engine
					opts.replacementInterpreter = entry.replacementInterpreter
				end
				require("grug-far").open(opts)
			end,
			mode = { "n", "x" },
			desc = "grug-far using last history entry",
		},
	},
}
