-- Install lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Set leader and localleader. This is required before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load plugins with lazy loading
require('lazy').setup('plugins')

-- All custom configs
require("insane")
