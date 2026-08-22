local map = vim.keymap.set
vim.g.mapleader = " "

map('t', '<Esc>', '<C-\\><C-n>')

map("n", "<Up>", "k")
map("n", "<Down>", "j")
map("n", "<Left>", "h")
map("n", "<Right>", "l")
