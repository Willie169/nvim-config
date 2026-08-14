return {
	"Willie169/zhuyin-pinyin.nvim",
	event = "VeryLazy",
	config = function()
		require("zhuyin-pinyin").setup()
	end,
}
