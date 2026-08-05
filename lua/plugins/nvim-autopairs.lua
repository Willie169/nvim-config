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
			Rule("\\(", "\\)"),
		})
		npairs.add_rules({
			Rule("\\[", "\\]"),
		})
		npairs.add_rules({
			Rule("\\{", "\\}"),
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
	end,
}
