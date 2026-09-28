require("neo-tree").setup {
	hijack_netrw_behavior = "disabled";

	filesystem = {
		filtered_items = {
			visible = true;
		};
		window = {
			position = "float";
			popup = {
				size = {
					height = "80%";
					width = "75%";
				};
				position = "50%";
			};
		};
	};
}

vim.keymap.set("n", "<leader>e",  "<cmd>Neotree float toggle<CR>")
