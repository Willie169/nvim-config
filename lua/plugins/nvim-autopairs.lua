return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		local npairs = require("nvim-autopairs")
		local Rule = require("nvim-autopairs.rule")
		local cond = require("nvim-autopairs.conds")
		local ts_conds = require("nvim-autopairs.ts-conds")

		npairs.setup({ check_ts = true })
		npairs.add_rules(
			Rule("$", "$", { "tex", "latex" }),
			Rule("$$", "$$", { "tex", "latex" }),
			Rule("\\(", "\\)", { "tex", "latex" }),
			Rule("\\[", "\\]", { "tex", "latex" }),
			{
				Rule("=", "")
					:with_pair(cond.not_inside_quote())
					:with_pair(function(opts)
						local last_char = opts.line:sub(opts.col - 1, opts.col - 1)
						if last_char:match("[%w%=%s]") then
							return true
						end
						return false
					end)
					:replace_endpair(function(opts)
						local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
						local next_char = opts.line:sub(opts.col, opts.col)
						next_char = next_char == " " and "" or " "
						if prev_2char:match("%w$") then
							return "<bs> =" .. next_char
						end
						if prev_2char:match("%=$") then
							return next_char
						end
						if prev_2char:match("=") then
							return "<bs><bs>=" .. next_char
						end
						return ""
					end)
					:set_end_pair_length(0)
					:with_move(cond.none())
					:with_del(cond.none()),
			},
			{
				Rule("{", "},", "lua")
					:with_pair(cond.not_after_regex(","))
					:with_pair(ts_conds.is_ts_node({ "table_constructor" })),
			},
			{
				Rule("'", "',", "lua")
					:with_pair(cond.not_after_regex(","))
					:with_pair(ts_conds.is_ts_node({ "table_constructor" })),
			},
			{
				Rule('"', '",', "lua")
					:with_pair(cond.not_after_regex(","))
					:with_pair(ts_conds.is_ts_node({ "table_constructor" })),
			}
		)
	end,
}
