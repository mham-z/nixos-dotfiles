require("auto-session").setup {
	auto_save = true;
	auto_restore = true;
	git_use_branch_name = true;

	suppressed_dirs = {
		vim.fn.expand("~");
	};

	post_restore_cmds = {
		function()
			require("neo-tree.command").execute {
				action = "focus";
				source = "filesystem";
				reveal = true;
			}
		end;
	};

	no_restore_cmds = {
		function()
			require("neo-tree.command").execute {
				action = "focus";
				source = "filesystem";
			}
		end;
	};
}
