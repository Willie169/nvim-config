return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-mini/mini.icons", "lewis6991/gitsigns.nvim", "lilydjwg/fcitx.vim" },
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },
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

		local function search_stat()
			if vim.v.hlsearch ~= 1 then
				return ""
			end
			local search_info = vim.fn.searchcount({ maxcount = 0 })
			local incomplete = search_info.incomplete or 0
			local total = search_info.total or 0
			local current = search_info.current or 0
			return incomplete > 0 and "[?/?]" or total > 0 and ("[%s/%s]"):format(current, total) or ""
		end

		local function file_status()
			local symbols = ""
			if vim.fn.expand("%:t") == "" then
				symbols = symbols .. "[No Name]"
			end
			if vim.bo.modifiable == false or vim.bo.readonly == true then
				symbols = symbols .. "[-]"
			elseif vim.bo.modified then
				symbols = symbols .. "[+]"
			else
				symbols = symbols .. "[.]"
			end
			local function is_new_file()
				local filename = vim.fn.expand("%")
				return filename ~= ""
					and filename:match("^%a+://") == nil
					and vim.bo.buftype == ""
					and vim.fn.filereadable(filename) == 0
			end
			if is_new_file() then
				symbols = symbols .. "[New]"
			end
			return symbols
		end

		local function ts_node()
			local node = vim.treesitter.get_node()
			return node and node:type() or ""
		end

		local function fcitx_current_im()
			if vim.fn.exists("*" .. "FcitxCurrentIM") == 1 then
				return vim.fn["FcitxCurrentIM"]()
			end
			return ""
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
					{
						fcitx_current_im,
						on_click = function()
							if vim.fn.exists("*" .. "Fcitx2en") == 1 then
								if fcitx_current_im() == "keyboard-us" then
									vim.fn["Fcitx2zh"]()
								else
									vim.fn["Fcitx2en"]()
								end
							end
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
				},
				lualine_c = {
					{
						"diagnostics",
						on_click = function()
							vim.cmd("Trouble diagnostics toggle filter.buf=0")
						end,
					},
					{
						ts_node,
						on_click = function()
							vim.cmd("InspectTree")
						end,
					},
				},
				lualine_x = {
					{
						file_status,
						on_click = function()
							vim.cmd("FzfLua files")
						end,
					},
				},
				lualine_y = {
					{
						"lsp_status",
						icons_enabled = false,
						on_click = function()
							vim.cmd("FzfLua command_history")
						end,
					},
					{
						search_stat,
						on_click = function()
							local search = vim.fn.getreg("/")
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
				},
				lualine_z = {
					{
						"progress",
						on_click = function()
							vim.cmd("FzfLua search_history")
						end,
					},
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
