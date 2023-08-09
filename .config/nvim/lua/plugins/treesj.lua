return {
	'Wansmer/treesj',
	-- keys = { '<space>j' },
	dependencies = { 'nvim-treesitter/nvim-treesitter' },
    cond = function()
        return not vim.g.vscode
    end,
	config = function()
		require('treesj').setup({
			use_default_keymaps = false,
		})
	end,
}

