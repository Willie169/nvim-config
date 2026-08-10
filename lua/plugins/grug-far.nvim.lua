return {
	"MagicDuck/grug-far.nvim",
	dependencies = { "nvim-mini/mini.icons" },
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },
	opts = { headerMaxWidth = 80 },
	keys = {
		{
			"<leader>jg",
			function()
				require("grug-far").open({
					transient = true,
					prefills = {
						paths = vim.fn.fnameescape(vim.fn.expand("%")),
					},
				})
			end,
			mode = { "n", "x" },
			desc = "grug-far current file",
		},
		{
			"<leader>jh",
			function()
				require("grug-far").open({
					transient = true,
					prefills = {
						flags = "-i",
						paths = vim.fn.fnameescape(vim.fn.expand("%")),
					},
				})
			end,
			mode = { "n", "x" },
			desc = "grug-far case-insensitive current file",
		},
		{
			"<leader>ji",
			function()
				local ext = vim.bo.buftype == "" and vim.fn.fnameescape(vim.fn.expand("%:e"))
				require("grug-far").open({
					transient = true,
					prefills = {
						filesFilter = ext and ext ~= "" and "*." .. ext or nil,
					},
				})
			end,
			mode = { "n", "x" },
			desc = "grug-far current file type",
		},
		{
			"<leader>jj",
			function()
				require("grug-far").open({
					transient = true,
					prefills = {
						paths = vim.fn.fnameescape(vim.fn.expand("%")),
					},
				})
			end,
			mode = { "n", "x" },
			desc = "grug-far",
		},
		{
			"<leader>jc",
			function()
				require("grug-far").open({
					transient = true,
					prefills = {
						search = vim.fn.expand("<cword>"),
						paths = vim.fn.fnameescape(vim.fn.expand("%")),
					},
				})
			end,
			mode = { "n", "x" },
			desc = "grug-far current word curent file",
		},
		{
			"<leader>jd",
			function()
				require("grug-far").open({
					transient = true,
					prefills = {
						search = vim.fn.expand("<cword>"),
						flags = "-i",
						paths = vim.fn.fnameescape(vim.fn.expand("%")),
					},
				})
			end,
			mode = { "n", "x" },
			desc = "grug-far current word case-insensitive current file",
		},
		{
			"<leader>je",
			function()
				local ext = vim.bo.buftype == "" and vim.fn.fnameescape(vim.fn.expand("%:e"))
				require("grug-far").open({
					transient = true,
					prefills = {
						search = vim.fn.expand("<cword>"),
						filesFilter = ext and ext ~= "" and "*." .. ext or nil,
					},
				})
			end,
			mode = { "n", "x" },
			desc = "grug-far current word current file type",
		},
		{
			"<leader>jf",
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
						paths = vim.fn.fnameescape(vim.fn.expand("%")),
					},
				})
			end,
			mode = { "n", "x" },
			desc = "grug-far @/ current file",
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
						paths = vim.fn.fnameescape(vim.fn.expand("%")),
					},
				})
			end,
			mode = { "n", "x" },
			desc = "grug-far @/ case-insensitive current file",
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
				local ext = vim.bo.buftype == "" and vim.fn.fnameescape(vim.fn.expand("%:e"))
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
			"<leader>jv",
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
