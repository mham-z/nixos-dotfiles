local map = vim.keymap.set
vim.g.mapleader = " "

map("n", "<Up>", "k")
map("n", "<Down>", "j")
map("n", "<Left>", "h")
map("n", "<Right>", "l")

map("n", "<leader>e", "<cmd>Neotree toggle<CR>")
map("n", "<leader>g", "<cmd>Neogit<CR>")

-- panes
map("n", "<C-Left>", "<C-w>h")
map("n", "<C-Down>", "<C-w>j")
map("n", "<C-Up>", "<C-w>k")
map("n", "<C-Right>", "<C-w>l")
map("n", "<leader>v", "<cmd>vsplit<CR>")
map("n", "<leader>s", "<cmd>split<CR>")
map("n", "<leader>q", "<cmd>close<CR>")