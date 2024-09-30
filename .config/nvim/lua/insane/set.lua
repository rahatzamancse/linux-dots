if not vim.g.vscode then
	vim.opt.relativenumber = true
	vim.opt.smartindent = true
	vim.opt.scrolloff = 8
end

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.keymap.set({'n', 'v'}, 'y', function()
    if vim.v.register == '"' then
        return '"+y'
    end

    return 'y'
end, {expr = true})

