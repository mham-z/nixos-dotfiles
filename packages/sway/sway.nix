{pkgs, lib, ...}: {
	wayland.windowManager.sway = {
		enable = true;
		package = pkgs.sway;
		config = null;
		systemd = {
			enable = true;
			variables = ["--all"];
		};
	};

	xdg.configFile = {
		"sway/config".source = lib.mkForce ./config;
		"sway/configs" = {
			source = ./configs;
			recursive = true;
		};
	};
}
