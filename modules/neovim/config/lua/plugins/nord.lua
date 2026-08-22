vim.cmd.colorscheme("nord")

vim.api.nvim_set_hl(0, "Cursor", {
	reverse = true;
})

vim.api.nvim_set_hl(0, "NormalFloat", {
	bg = "#3b4252";
	fg = "#d8dee9";
})

vim.api.nvim_set_hl(0, "FloatBorder", {
	bg = "#3b4252";
	fg = "#81a1c1";
})

vim.api.nvim_set_hl(0, "Normal", {
	bg = "#333945";
	fg = "#D8DEE9";
})

vim.api.nvim_set_hl(0, "NormalNC", {
	bg = "#2E3440";
	fg = "#D8DEE9";
})
