{ config, pkgs, ... }: {
	home.stateVersion = "26.05";

	home.packages = with pkgs; [
		foot
		dmenu
		tofi
		firefox
	];
	
	wayland.windowManager.sway = {
		enable = true;
		
		systemd = {
			enable = true;
			variables = ["--all"];
		};

		config = {
			modifier = "Mod4";
			terminal = "foot";

			startup = [
				{command = "systemctl --user start sway-session.target";}
			];
		};
	};

	programs.waybar = {
		enable = true;
		systemd.enable = true;
		systemd.targets = ["sway-session.target"];
	};

	programs.git = {
		enable = true;
		settings.user = {
			name = "Hamza";
			email = "82454201+mham-z@users.noreply.github.com";
		};
	};

	home.pointerCursor = {
		gtk.enable = true;
		x11.enable = true;
		sway.enable = true;
		package = pkgs.adwaita-icon-theme;
		name = "Adwaita";
		size = 24;
	};

	programs.vscode = {
		enable = true;
		package = pkgs.vscode-insiders;
	};
}
