require("nvim-treesitter").setup {
	highlight = {
		enable = true;
	}
}

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.conceallevel = 2
vim.opt.concealcursor = "nc"
