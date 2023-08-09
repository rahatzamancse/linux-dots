return {
    'goolord/alpha-nvim',
    event = "VimEnter",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cond = function()
        return not vim.g.vscode
    end,
    config = function()
        require('alpha').setup(require('alpha.themes.startify').config)
    end
}