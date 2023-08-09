return {
    'phaazon/hop.nvim', branch = 'v2',
    keys = {
        {
            '<leader>w',
            mode = 'n',
            function()
                local hop = require('hop')
                local directions = require('hop.hint').HintDirection
                hop.hint_words({ direction = directions.AFTER_CURSOR })
            end,
            { noremap = true, silent = true },
            desc = 'Hop to word after cursor'
        },
        {
            '<leader>b',
            mode = 'n',
            function()
                local hop = require('hop')
                local directions = require('hop.hint').HintDirection
                hop.hint_words({ direction = directions.BEFORE_CURSOR })
            end,
            { noremap = true, silent = true },
            desc = 'Hop to word before cursor'
        },
    },
    cond = function()
        return not vim.g.vscode
    end,
    config = function()
        require("hop").setup()
    end
}