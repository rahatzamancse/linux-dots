return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = { "c", "lua", "javascript", "html", "bash", "bibtex", "cmake", "cpp", "css", "cuda", "dockerfile", "fish", "latex", "python", "rust", "typescript" },
            auto_install = true,
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },  
        })
    end
}