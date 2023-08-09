return {
    'petertriho/nvim-scrollbar',
    cond = function()
        return not vim.g.vscode
    end,
    config = function() 
        require("scrollbar").setup()
    end
}