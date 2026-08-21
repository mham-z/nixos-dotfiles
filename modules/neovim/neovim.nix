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
		];
	};

	xdg.configFile."nvim".source = ./config;
}
