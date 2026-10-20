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
opt.termguicolors = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = false

vim.api.nvim_create_autocmd('UIEnter', {
	callback = function()
		vim.o.clipboard = 'unnamedplus'
	end;
})

vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.hl.on_yank()
	end;
})

vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("RojoSourcemap", {clear = true}),
	pattern = {"*.luau"},
	callback = function()
		if vim.fn.filereadable("default.project.json") == 1 then
			vim.fn.jobstart {"rojo", "sourcemap", "default.project.json", "--output", "sourcemap.json" }
		end
	end,
})
