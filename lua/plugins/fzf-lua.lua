return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-mini/mini.icons" },
    config=function()
        require("fzf-lua").setup({
            {"telescope","fzf-native"}
        })
    end
}
