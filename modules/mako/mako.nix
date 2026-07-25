{pkgs, ...}: {
	home.packages = with pkgs; [
		libnotify
	];

	services.mako = {
		enable = true;
	};

	xdg.configFile = {
		"mako" = {
			source = ./.;
			recursive = true;
		};
	};
}