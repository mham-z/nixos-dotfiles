require("auto-session").setup {
	auto_save = true;
	auto_restore = true;
	git_use_branch_name = true;

	suppressed_dirs = {
		vim.fn.expand("~");
	};

	bypass_save_filetypes = {"neo-tree"};

	pre_save_cmds = {
		function()
			vim.cmd("Neotree close")
		end;
	};

	post_restore_cmds = {};
	no_restore_cmds = {};
}
