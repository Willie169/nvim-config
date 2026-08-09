vim.lsp.enable("bashls")
vim.lsp.enable("clangd")
vim.lsp.enable("cmake")
vim.lsp.enable("docker_language_server")
vim.lsp.enable("jdtls")
vim.lsp.enable("gopls")
vim.lsp.enable("kotlin_language_server")
vim.lsp.enable("lua_ls")
vim.lsp.enable("marksman")
vim.lsp.enable("perlpls")
vim.lsp.enable("pyright")
vim.lsp.enable("quick_lint_js")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("superhtml")
vim.lsp.enable("texlab")
vim.lsp.enable("verible")
vim.lsp.config("jsonls", {
	cmd = function(dispatchers, config)
		local cmd = "vscode-json-languageserver"
		if (config or {}).root_dir then
			local local_cmd = vim.fs.joinpath(config.root_dir, "node_modules/.bin", cmd)
			if vim.fn.executable(local_cmd) == 1 then
				cmd = local_cmd
			end
		end
		return vim.lsp.rpc.start({ cmd, "--stdio" }, dispatchers)
	end,
})
vim.lsp.enable("jsonls")
vim.lsp.enable("yamlls")
vim.keymap.set({ "n", "x" }, "sd", "<C-W>d", {
	remap = true,
})
