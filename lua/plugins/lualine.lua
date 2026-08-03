return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", "lewis6991/gitsigns.nvim" },
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

			require("lualine").setup({
				sections = {
					lualine_a = { "mode" },
					lualine_b = { { "b:gitsigns_head", icon = "" }, { "diff", source = diff_source }, "diagnostics" },
					lualine_c = { "file_name" },
					lualine_x = { "buffers" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		end,
	},
}
