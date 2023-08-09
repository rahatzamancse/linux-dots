return {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    cond = function()
        return not vim.g.vscode
    end,
    opts = {
        -- configurations go here
    },
}