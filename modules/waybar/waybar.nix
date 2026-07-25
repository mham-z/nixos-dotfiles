{...}: {
  programs.waybar = {
		enable = true;
		systemd = {
			enable = true;
			targets = ["graphical-session.target"];
		};
	};

  xdg.configFile = {
		"waybar" = {
			source = ./.;
			recursive = true;
		};
	};
}