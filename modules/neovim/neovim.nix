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
		];

		extraPackages = with pkgs; [
			ripgrep
			fd
		];
	};

	xdg.configFile."nvim".source = ./config;
}