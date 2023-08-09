-- hlslens variables
local kopts = { noremap = true, silent = true }

return {
	'mrjones2014/legendary.nvim',
	-- since legendary.nvim handles all your keymaps/commands,
	-- its recommended to load legendary.nvim before other plugins
	priority = 10000,
	lazy = false,
	-- sqlite is only needed if you want to use frecency sorting
	dependencies = { 'kkharji/sqlite.lua' },
    cond = function()
        return not vim.g.vscode
    end,
	opts = {
		keymaps = {
			{
				'<leader>u',
				{ n = ":UndotreeToggle<CR>:UndotreeFocus<CR>" },
				description = "Toggle undotree"
			},
			{
				'J',
				{ v = ":m '>+1<CR>gv=gv" },
				description = "Move line down"
			},
			{
				'K',
				{ v = ":m '<-2<CR>gv=gv" },
				description = "Move line up"
			},
			{
				"<leader>p",
				{ x = "\"_dP" },
				description = "Keep to yank after pasting"
			},
			{
				"<leader>y",
				{ n = "\"+y", v = "\"+y" },
				description = "Yank to system clipboard"
			},
			{
				"<leader>Y",
				{ n = "\"+Y" },
				description = "Yank to system clipboard"
			},
			{
				"n",
				{ n = [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]] },
				opts = kopts,
				description = "Search next (hlslens)"
			},
			{
				"N",
				{ n = [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]] },
				opts = kopts,
				description = "Search previous (hlslens)"
			},
			{
				'*', { n = [[*<Cmd>lua require('hlslens').start()<CR>]] }, opts = kopts, description = "Search previous word under cursor (hlslens)"
			},
			{
				'#', { n = [[#<Cmd>lua require('hlslens').start()<CR>]] }, opts = kopts, description = "Search previous word under cursor (hlslens)"
			},
			{
				'g*', { n = [[g*<Cmd>lua require('hlslens').start()<CR>]] }, opts = kopts, description = "Search next word under cursor (hlslens)"
			},
			{
				'g#', { n = [[g#<Cmd>lua require('hlslens').start()<CR>]] }, opts = kopts, description = "Search previous word under cursor (hlslens)"
			},
			{
				'<Leader>l', { n = '<Cmd>noh<CR>' }, opts = kopts, description = "Clear highlights"
			},
			-- treesj
			{
				"<leader>j", { n = [[<Cmd>lua require('treesj').toggle()<CR>]] }, description = "Join braces"
			}
		}
	}
}
