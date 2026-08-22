{pkgs, ...}:
{
	programs.neovim = {
		enable = true;

		defaultEditor = true;
		viAlias = true;
		vimAlias = true;

		plugins = with pkgs.vimPlugins; [
			nord-nvim
			neo-tree-nvim
			lualine-nvim
			gitsigns-nvim
			neogit
			telescope-nvim
			nvim-spectre
			cord-nvim
			blink-cmp
			ccc-nvim
		];

		extraPackages = with pkgs; [
			lua-language-server
			luau-lsp
			nil
			clang-tools
			basedpyright
			vscode-langservers-extracted
			texlab
			marksman
		];
	};

	xdg.configFile."nvim".source = ./config;
}
