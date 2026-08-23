require("gitsigns").setup()

vim.keymap.set('n', '<leader>ba', "<cmd>Gitsigns blame<CR>")
vim.keymap.set('n', '<leader>bb', "<cmd>Gitsigns blame_line<CR>")
