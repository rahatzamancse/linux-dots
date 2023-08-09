return {
    'nvim-telescope/telescope.nvim', tag = '0.1.2',
    cond = function()
        return not vim.g.vscode
    end,
    dependencies = { 'nvim-lua/plenary.nvim' }
}