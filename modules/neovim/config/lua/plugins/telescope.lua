require("telescope").setup {
}

vim.keymap.set("n", "<leader>f",  "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<leader>s",  "<cmd>Telescope live_grep<CR>")
