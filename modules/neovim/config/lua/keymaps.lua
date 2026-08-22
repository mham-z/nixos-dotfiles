local map = vim.keymap.set
vim.g.mapleader = " "

map('t', '<Esc>', '<C-\\><C-n>')

map("n", "<Up>", "k")
map("n", "<Down>", "j")
map("n", "<Left>", "h")
map("n", "<Right>", "l")

map("n", "<leader>e",  "<cmd>Neotree toggle<CR>")
map("n", "<leader>g",  "<cmd>Neogit<CR>")
map("n", "<leader>f",  "<cmd>Telescope find_files<CR>")
map("n", "<leader>s",  "<cmd>Telescope live_grep<CR>")
map("n", "<leader>r",  "<cmd>Spectre<CR>")
map("n", "<leader>cp", "<cmd>CccPick<CR>")
