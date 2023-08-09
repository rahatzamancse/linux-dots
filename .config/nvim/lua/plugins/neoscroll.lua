return {
    'karb94/neoscroll.nvim',
    cond = function()
        return not vim.g.vscode
    end,
    config = function()
        require('neoscroll').setup()
    end
}