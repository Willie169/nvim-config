return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	config = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "TSUpdate",
			callback = function()
				require("nvim-treesitter.parsers").latex.install_info = {
					generate = false,
					url = "https://github.com/Willie169/tree-sitter-latex",
					location = "tree-sitter-latex",
				}
			end,
		})

		require("nvim-treesitter").setup()
		require("nvim-treesitter").install({
			"arduino",
			"asm",
			"awk",
			"bash",
			"bibtex",
			"c",
			"c_sharp",
			"cmake",
			"cpp",
			"css",
			"csv",
			"desktop",
			"diff",
			"dockerfile",
			"editorconfig",
			"git_config",
			"git_rebase",
			"gitattributes",
			"gitcommit",
			"gitignore",
			"go",
			"html",
			"java",
			"javascript",
			"jq",
			"jsdoc",
			"json",
			"kotlin",
			"latex",
			"lua",
			"luadoc",
			"luap",
			"make",
			"markdown",
			"markdown_inline",
			"meson",
			"ninja",
			"nix",
			"perl",
			"php",
			"powershell",
			"printf",
			"python",
			"regex",
			"query",
			"rust",
			"sql",
			"systemverilog",
			"toml",
			"tsx",
			"typescript",
			"vhdl",
			"vim",
			"vimdoc",
			"xml",
			"yaml",
			"zsh",
		})
		vim.treesitter.language.register("xml", { "svg", "xslt" })
		vim.treesitter.language.register("latex", { "tex" })
		vim.treesitter.language.register("bash", { "sh" })
		vim.treesitter.language.register("systemverilog", { "v" })

		---@param buf integer
		---@param language string
		local function treesitter_try_attach(buf, language)
			-- Check if a parser exists and load it
			if not vim.treesitter.language.add(language) then
				return
			end
			-- Enable syntax highlighting and other treesitter features
			vim.treesitter.start(buf, language)

			-- Enable treesitter based folds
			-- For more info on folds see `:help folds`
			vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.wo.foldmethod = "expr"
			vim.opt.foldenable = true
			vim.opt.foldlevel = 99

			-- Check if treesitter indentation is available for this language, and if so enable it
			-- in case there is no indent query, the indentexpr will fallback to the vim's built in one
			local has_indent_query = vim.treesitter.query.get(language, "indents") ~= nil

			-- Enable treesitter based indentation
			if has_indent_query then
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end
		end

		local available_parsers = require("nvim-treesitter").get_available()
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local buf, filetype = args.buf, args.match

				local language = vim.treesitter.language.get_lang(filetype)
				if not language then
					return
				end

				local installed_parsers = require("nvim-treesitter").get_installed("parsers")

				if vim.tbl_contains(installed_parsers, language) then
					-- Enable the parser if it is already installed
					treesitter_try_attach(buf, language)
				elseif vim.tbl_contains(available_parsers, language) then
					-- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
					require("nvim-treesitter").install(language):await(function()
						treesitter_try_attach(buf, language)
					end)
				else
					-- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
					treesitter_try_attach(buf, language)
				end
			end,
		})

		vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.wo[0][0].foldmethod = "expr"
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
}
