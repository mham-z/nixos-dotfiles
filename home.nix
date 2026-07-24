{ config, pkgs, ... }: {
	home.stateVersion = "26.05";

	home.packages = with pkgs; [
		foot
		dmenu
		tofi
		bluetui
		
		noto-fonts
		noto-fonts-color-emoji
		nerd-fonts.adwaita-mono
		nerd-fonts.symbols-only
		nerd-fonts.noto
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

	gtk = {
		enable = true;
		gtk3.extraConfig = {
			gtk-application-prefer-dark-theme = 1;
		};
	};

	dconf.settings = {
		"org/gnome/desktop/interface" = {
			color-scheme = "prefer-dark";
		};
	};

	programs.vscode = {
		enable = true;
		package = pkgs.vscode-insiders;
	};
}
