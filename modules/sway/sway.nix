{pkgs, lib, inputs, ...}: {
	wayland.windowManager.sway = {
		enable = true;
		package = inputs.swayfx.packages.${pkgs.system}.default;
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
