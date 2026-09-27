{pkgs, ...}: {
	programs.vifm = {
		enable = true;
		package = pkgs.vifm-full;
	};

	xdg.configFile."vifm/vifmrc".source = ./config/vifmrc;
	xdg.configFile."vifm/colors".source = ./config/colors;
	xdg.configFile."vifm/modules".source = ./config/modules;
}
