function match_delimiter(open, close, ignored_ts_node)
	local bufnr = 0
	local parser = vim.treesitter.get_parser(bufnr)
	local tree = parser:parse()[1]
	local root = tree:root()

	local ignored = {}
	for _, node_type in ipairs(ignored_ts_node) do
		ignored[node_type] = true
	end

	local ignored_ranges = {}
	local function walk(node)
		if ignored[node:type()] then
			local sr, sc, er, ec = node:range()
			table.insert(ignored_ranges, {
				sr = sr,
				sc = sc,
				er = er,
				ec = ec,
			})
			return
		end

		for child in node:iter_children() do
			walk(child)
		end
	end
	walk(root)

	local function is_ignored(row, col)
		for _, range in ipairs(ignored_ranges) do
			if row >= range.sr and row <= range.er then
				if row > range.sr and row < range.er then
					return true
				elseif row == range.sr and row == range.er then
					return col >= range.sc and col < range.ec
				elseif row == range.sr then
					return col >= range.sc
				elseif row == range.er then
					return col < range.ec
				end
			end
		end
		return false
	end

	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local balance = 0
	local output = ""

	for row, line in ipairs(lines) do
		local line_number = row
		for col = 1, #line do
			local ts_row = row - 1
			local ts_col = col - 1
			if not is_ignored(ts_row, ts_col) then
				local char = line:sub(col, col)
				if char == open then
					balance = balance + 1
				elseif char == close then
					balance = balance - 1
				end
			end
		end
		output = output .. "\n" .. string.format("%2d %5d %s", balance, line_number, line)
	end
	return output
end

function match_round()
	return match_delimiter("(", ")", {
		"line_comment",
		"comment",
		"string",
	})
end

function match_square()
	return match_delimiter("[", "]", {
		"line_comment",
		"comment",
		"string",
	})
end

function match_curly()
	return match_delimiter("{", "}", {
		"line_comment",
		"comment",
		"string",
	})
end

vim.keymap.set("n", "<leader>(", match_round, { desc = "Match round brackets" })
vim.keymap.set("n", "<leader>[", match_square, { desc = "Match square brackets" })
vim.keymap.set("n", "<leader>{", match_curly, { desc = "Match curly brackets" })
