return {
	"MagicDuck/grug-far.nvim",
	dependencies = { "nvim-mini/mini.icons" },
	opts = { headerMaxWidth = 80 },
	keys = {
		{
			"<leader>jg",
			function()
				require("grug-far").open({
					transient = true,
				})
			end,
			mode = { "n", "x" },
			desc = "grug-far",
		},
		{
			"<leader>jh",
			function()
				require("grug-far").open({
					transient = true,
					prefills = {
						flags = "-i",
					},
				})
			end,
			mode = { "n", "x" },
			desc = "grug-far case-insensitive",
		},
		{
			"<leader>ji",
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
			"<leader>jc",
			function()
				require("grug-far").open({
					transient = true,
					prefills = {
						search = vim.fn.expand("<cword>"),
					},
				})
			end,
			mode = { "n", "x" },
			desc = "grug-far current word",
		},
		{
			"<leader>jd",
			function()
				require("grug-far").open({
					transient = true,
					prefills = {
						search = vim.fn.expand("<cword>"),
						flags = "-i",
					},
				})
			end,
			mode = { "n", "x" },
			desc = "grug-far current word case-insensitive",
		},
		{
			"<leader>je",
			function()
				local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
				require("grug-far").open({
					transient = true,
					prefills = {
						search = vim.fn.expand("<cword>"),
						filesFilter = ext and ext ~= "" and "*." .. ext or nil,
					},
				})
			end,
			mode = { "n", "x" },
			desc = "grug-far current word in current file type",
		},
		{
			"<leader>js",
			function()
				local search = vim.fn.getreg("/")
				-- surround with \b if "word" search (such as when pressing `*`)
				if search and vim.startswith(search, "\\<") and vim.endswith(search, "\\>") then
					search = "\\b" .. search:sub(3, -3) .. "\\b"
				elseif search and vim.startswith(search, "\\V") then
					search = search:sub(3)
				end
				require("grug-far").open({
					transient = true,
					prefills = {
						search = search,
					},
				})
			end,
			mode = { "n", "x" },
			desc = "grug-far @/",
		},
		{
			"<leader>jt",
			function()
				local search = vim.fn.getreg("/")
				-- surround with \b if "word" search (such as when pressing `*`)
				if search and vim.startswith(search, "\\<") and vim.endswith(search, "\\>") then
					search = "\\b" .. search:sub(3, -3) .. "\\b"
				elseif search and vim.startswith(search, "\\V") then
					search = search:sub(3)
				end
				require("grug-far").open({
					transient = true,
					prefills = {
						search = search,
						flags = "-i",
					},
				})
			end,
			mode = { "n", "x" },
			desc = "grug-far @/ case-insensitive",
		},
		{
			"<leader>ju",
			function()
				local search = vim.fn.getreg("/")
				-- surround with \b if "word" search (such as when pressing `*`)
				if search and vim.startswith(search, "\\<") and vim.endswith(search, "\\>") then
					search = "\\b" .. search:sub(3, -3) .. "\\b"
				elseif search and vim.startswith(search, "\\V") then
					search = search:sub(3)
				end
				local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
				require("grug-far").open({
					transient = true,
					prefills = {
						search = search,
						filesFilter = ext and ext ~= "" and "*." .. ext or nil,
					},
				})
			end,
			mode = { "n", "x" },
			desc = "grug-far @/ in current file type",
		},
		{
			"<leader>jl",
			function()
				local opts = {}
				local entry = require("grug-far").get_last_history_entry()
				if entry ~= nil then
					opts.transient = true
					opts.prefills = entry
					opts.engine = entry.engine
					opts.replacementInterpreter = entry.replacementInterpreter
				end
				require("grug-far").open(opts)
			end,
			mode = { "n", "x" },
			desc = "grug-far last history entry",
		},
	},
}
