return {
	"akinsho/bufferline.nvim",
	version = "*",
	event = "VeryLazy",
	dependencies = { "nvim-mini/mini.icons" },
	keys = {
		{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
		{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
		{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
		{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
		{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
		{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
		{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
		{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
		{ "[m", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
		{ "]m", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
		{ "<leader>bj", "<cmd>BufferLinePick<cr>", desc = "Pick Buffer" },
	},
	config = function()
		require("bufferline").setup({
			options = {
				close_command = "bdelete %d",
				right_mouse_command = "bdelete %d",
				middle_mouse_command = "BufferLineCloseRight",
				diagnostics = "nvim_lsp",
				get_element_icon = function(element)
					local icon, hl = require("mini.icons").get_icon_by_filetype(element.filetype, { default = false })
					return icon, hl
				end,
				always_show_bufferline = true,
				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" },
				},
			custom_areas = {
				right = function()
					local result = {}
					local seve = vim.diagnostic.severity
					local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
					local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
					local info = #vim.diagnostic.get(0, { severity = seve.INFO })
					local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

					if error ~= 0 then
						table.insert(result, { text = "  " .. error, link = "DiagnosticError" })
					end

					if warning ~= 0 then
						table.insert(result, { text = "  " .. warning, link = "DiagnosticWarn" })
					end

					if hint ~= 0 then
						table.insert(result, { text = "  " .. hint, link = "DiagnosticHint" })
					end

					if info ~= 0 then
						table.insert(result, { text = "  " .. info, link = "DiagnosticInfo" })
					end
					return result
				end,
			},
			},
			highlights = require("catppuccin.special.bufferline").get_theme(),
		})
		-- Fix bufferline when restoring a session
		vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
			callback = function()
				vim.schedule(function()
					pcall(nvim_bufferline)
				end)
			end,
		})
	end,
}
