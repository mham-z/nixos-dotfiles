{pkgs, lib, ...}: {
	wayland.windowManager.sway = {
		enable = true;
		package = pkgs.sway;
		config = null;
	};

	xdg.configFile = {
		"sway/config".source = lib.mkForce ./config;
		"sway/configs" = {
			source = ./configs;
			recursive = true;
		};
	};
}
