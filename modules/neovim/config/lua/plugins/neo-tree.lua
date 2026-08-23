require("neo-tree").setup {
	filesystem = {
		filtered_items = {
			visible = true;
		};
		window = {
			position = "left";
			width = 40;
		};
	};
}

vim.api.nvim_create_autocmd("TabNew", {
	callback = function()
		vim.schedule(function()
			require("neo-tree.command").execute {
				action = "show";
				source = "filesystem";
			}
		end)
	end;
})

vim.keymap.set("n", "<leader>e",  "<cmd>Neotree toggle<CR>")
