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
				:with_pair(ts_conds.is_not_ts_node({ "code" })),
		})
		npairs.add_rules({
			Rule("\\(", "\\)", { "tex", "latex", "plaintex" }),
		})
		npairs.add_rules({
			Rule("\\[", "\\]", { "tex", "latex", "plaintex" }),
		})
		npairs.add_rules({
			Rule("\\{", "\\}", { "tex", "latex", "plaintex" }),
		})
		npairs.get_rules("'")[1].not_filetypes = { { "tex", "latex", "plaintex", "grug-far" } }
		npairs.get_rules('"')[1].not_filetypes = { { "tex", "latex", "plaintex", "grug-far" } }
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
		npairs.get_rules("`")[1].not_filetypes = { "grug-far" }
		npairs.get_rules("(")[1].not_filetypes = { "grug-far" }
		npairs.get_rules("[")[1].not_filetypes = { "grug-far" }
		npairs.get_rules("{")[1].not_filetypes = { "grug-far" }
		npairs.get_rules("'")[1]:with_pair(ts_conds.is_not_ts_node({ "string" }))
		npairs.get_rules('"')[1]:with_pair(ts_conds.is_not_ts_node({ "string" }))
	end,
}
