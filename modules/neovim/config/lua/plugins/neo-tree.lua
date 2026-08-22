require("neo-tree").setup {
	filesystem = {
		filtered_items = {
			visible = true;
		};
	};
}

vim.keymap.set("n", "<leader>e",  "<cmd>Neotree toggle<CR>")
