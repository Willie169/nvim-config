return {
	{
		"lambdalisue/vim-suda",
		lazy = false,

		init = function()
			vim.api.nvim_create_user_command("W", function(opts)
				local args = opts.args ~= "" and " " .. vim.fn.fnameescape(opts.args) or ""
				vim.cmd("SudaWrite" .. args)
			end, {
				nargs = "?",
				complete = "file",
			})

			vim.api.nvim_create_user_command("Wq", function(opts)
				local args = opts.args ~= "" and " " .. vim.fn.fnameescape(opts.args) or ""

				vim.cmd("SudaWrite" .. args)

				if vim.v.shell_error == 0 then
					vim.cmd("quit")
				end
			end, {
				nargs = "?",
				complete = "file",
			})
		end,
	},
}
