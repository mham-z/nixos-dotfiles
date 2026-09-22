{pkgs, ...}: {
	programs.vifm = {
		enable = true;
		package = pkgs.vifm-full;
	};

	xdg.configFile."vifm".source = ./config;
}
