return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-mini/mini.icons", "lewis6991/gitsigns.nvim" },
	config = function()
		local function diff_source()
			local gitsigns = vim.b.gitsigns_status_dict
			if gitsigns then
				return {
					added = gitsigns.added,
					modified = gitsigns.changed,
					removed = gitsigns.removed,
				}
			end
		end

		local trouble = require("trouble")
		local symbols = trouble.statusline({
			mode = "lsp_document_symbols",
			groups = {},
			title = false,
			filter = { range = true },
			format = "{kind_icon}{symbol.name:Normal}",
			-- The following line is needed to fix the background color
			-- Set it to the lualine section you want to use
			hl_group = "lualine_c",
		})

		local search_stat
		if vim.v.hlsearch == 1 then
			local sinfo = vim.fn.searchcount({ maxcount = 0 })
            local incomplete = sinfo.incomplete or 0
			search_stat = incomplete > 0 and "[?/?]"
				or sinfo.total > 0 and ("[%s/%s]"):format(sinfo.current, sinfo.total)
				or ""
		end

		require("lualine").setup({
			sections = {
				lualine_a = {
					{
						"mode",
						on_click = function()
							require("grug-far").open({
								transient = true,
								prefills = {
									paths = vim.fn.fnameescape(vim.fn.expand("%")),
								},
							})
						end,
					},
				},
				lualine_b = {
					{
						"b:gitsigns_head",
						on_click = function()
							vim.cmd("FzfLua git_status")
						end,
					},
					{
						"diff",
						source = diff_source,
						on_click = function()
							vim.cmd("FzfLua git_diff")
						end,
					},
					{
						"diagnostics",
						on_click = function()
							vim.cmd("Trouble diagnostics toggle")
						end,
					},
				},
				lualine_c = {
					{
						symbols.get,
						cond = symbols.has,
						on_click = function()
							vim.cmd("InspectTree")
						end,
					},
				},
				lualine_x = {
					{
						"filename",
						on_click = function()
							vim.cmd("FzfLua files")
						end,
					},
					{
						"filetype",
						on_click = function()
							vim.cmd("FzfLua registers")
						end,
					},
				},
				lualine_y = {
					{
						"lsp_status",
						on_click = function()
							vim.cmd("FzfLua command_history")
						end,
					},
					{
						search_stat,
						on_click = function()
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
					},
					{
						"progress",
						on_click = function()
							vim.cmd("FzfLua search_history")
						end,
					},
				},
				lualine_z = {
					{
						"location",
						on_click = function()
							vim.cmd("FzfLua undotree")
						end,
					},
				},
			},
		})
	end,
}
