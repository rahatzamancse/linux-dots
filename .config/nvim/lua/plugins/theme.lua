return {
     "folke/tokyonight.nvim",
    cond = function()
        return not vim.g.vscode
    end,
}