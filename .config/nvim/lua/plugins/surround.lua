return {
	"kylechui/nvim-surround",
    cond = function()
        return not vim.g.vscode
    end,
	version = "*",
	event = "VeryLazy",
	opts = {},
}
