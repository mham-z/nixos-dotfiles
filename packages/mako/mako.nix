{pkgs, ...}: {
	home.packages = with pkgs; [
		libnotify
		mako
	];

  xdg.configFile = {
		"mako" = {
			source = ./.;
			recursive = true;
		};
	};
}