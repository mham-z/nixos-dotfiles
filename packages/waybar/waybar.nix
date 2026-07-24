{...}: {
  programs.waybar = {
		enable = true;
		systemd.enable = false;
	};

  xdg.configFile = {
		"waybar" = {
			source = ./.;
			recursive = true;
		};
	};
}