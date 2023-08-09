return {
	'kevinhwang91/nvim-hlslens',
    name = 'hlslens',
    cond = function()
        return not vim.g.vscode
    end,
    config = function()
        require('hlslens').setup()
    end
}