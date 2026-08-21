local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.wrap = false
opt.cursorline = true
opt.scrolloff = 10
opt.list = true
opt.confirm = true
opt.ignorecase = true
opt.smartcase = true

vim.api.nvim_create_autocmd('UIEnter', {
	callback = function()
		vim.o.clipboard = 'unnamedplus'
	end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	callback = function()
		vim.hl.on_yank()
	end,
})
