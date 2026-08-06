return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		local npairs = require("nvim-autopairs")
		local Rule = require("nvim-autopairs.rule")
		local cond = require("nvim-autopairs.conds")
		local ts_conds = require("nvim-autopairs.ts-conds")
		npairs.setup({ check_ts = true })
		npairs.add_rules({
			Rule("$", "$", { "tex", "latex", "plaintex" })
				:with_pair(cond.not_before_text("\\"))
				:with_pair(ts_conds.is_not_ts_node({ "code", "inline_formula", "displayed_equation" }))
				:with_move(cond.done()),
		})
		npairs.add_rules({
			Rule("\\(", "\\)", { "tex", "latex", "plaintex" })
				:with_pair(ts_conds.is_not_ts_node({ "code", "inline_formula", "displayed_equation" }))
				:with_move(cond.done()),
		})
		npairs.add_rules({
			Rule("\\[", "\\]", { "tex", "latex", "plaintex" })
				:with_pair(ts_conds.is_not_ts_node({ "code", "inline_formula", "displayed_equation" }))
				:with_move(cond.done()),
		})
		npairs.add_rules({
			Rule("\\{", "\\}", { "tex", "latex", "plaintex" })
				:with_pair(ts_conds.is_not_ts_node({ "code", "inline_formula", "displayed_equation" }))
				:with_move(cond.done()),
		})
		npairs.add_rules({
			Rule("*", "*", {
					"markdown",
					"vimwiki",
					"rmarkdown",
					"rmd",
					"pandoc",
					"quarto",
					"typst",
					"gitcommit",
				})
				:with_pair(cond.not_before_text("\\"))
				:with_pair(cond.not_before_char("*", 2))
				:with_pair(ts_conds.is_ts_node({ "code_span", "code_fence_content" }))
				:with_del(cond.after_text("**") and cond.done())
				:with_move(cond.done()),
		})
		npairs.add_rules({
			Rule("_", "_", {
					"markdown",
					"vimwiki",
					"rmarkdown",
					"rmd",
					"pandoc",
					"quarto",
					"typst",
					"gitcommit",
				})
				:with_pair(cond.not_before_text("\\"))
				:with_pair(cond.not_before_char("_", 2))
				:with_pair(ts_conds.is_ts_node({ "code_span", "code_fence_content" }))
				:with_del(cond.after_text("__") and cond.done())
				:with_move(cond.done()),
		})
		npairs.add_rules({
			Rule("{", "},", "lua")
				:with_pair(cond.not_after_regex(","))
				:with_pair(ts_conds.is_ts_node({ "table_constructor" })),
		})
		npairs.add_rules({
			Rule("'", "',", "lua")
				:with_pair(cond.not_after_regex(","))
				:with_pair(ts_conds.is_ts_node({ "table_constructor" })),
		})
		npairs.add_rules({
			Rule('"', '",', "lua")
				:with_pair(cond.not_after_regex(","))
				:with_pair(ts_conds.is_ts_node({ "table_constructor" })),
		})
		npairs.get_rules("(")[1].not_filetypes = { "grug-far" }
		npairs.get_rules("[")[1].not_filetypes = { "grug-far" }
		npairs.get_rules("{")[1].not_filetypes = { "grug-far" }
		npairs
			.get_rules("'")[1]
			:with_pair(cond.not_before_text("\\"))
			:with_pair(ts_conds.is_not_ts_node({ "string" }))
			:with_pair(cond.not_filetypes({ "tex", "latex", "plaintex", "grug-far" }))
		npairs
			.get_rules('"')[1]
			:with_pair(cond.not_before_text("\\"))
			:with_pair(ts_conds.is_not_ts_node({ "string" }))
			:with_pair(cond.not_filetypes({ "tex", "latex", "plaintex", "grug-far" }))
		npairs
			.get_rules("`")[1]
			:with_pair(ts_conds.is_not_ts_node({ "string" }))
			:with_pair(cond.not_filetypes({ "tex", "latex", "plaintex", "grug-far" }))
	end,
}
