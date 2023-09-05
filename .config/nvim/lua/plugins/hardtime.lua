return {
   "m4xshen/hardtime.nvim",
   dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
   cond = function()
       return not vim.g.vscode
   end,
   opts = {}
}
