{config, pkgs, ...}: {
	home.stateVersion = "26.05";

	home.packages = with pkgs; [
		cava
		cmd-polkit
		udiskie
		wlsunset
		wl-clipboard

		thunderbird
		nautilus
		bluetui
		aseprite
		blender
		
		noto-fonts
		noto-fonts-color-emoji
		nerd-fonts.adwaita-mono
		nerd-fonts.symbols-only
		nerd-fonts.noto
	];
	fonts.fontconfig.enable = true;

	imports = [
		./modules/sway/sway.nix
		./modules/waybar/waybar.nix
		./modules/tofi/tofi.nix
		./modules/mako/mako.nix
		./modules/fastfetch/fastfetch.nix
		./modules/foot/foot.nix
		./modules/nixcord/nixcord.nix
		./modules/autostart.nix
	];

	services.flameshot = {
		enable = true;
		settings = {
			General = {
				savePath = "/home/hamza/Pictures/Flameshot";
				disabledTrayIcon = false;
				showStartupLaunchMessage = false;
				saveAsFileExtension = ".png";
				showDesktopNotification = true;
				useGrimAdapter = true;
				disabledGrimWarning = true;
			};
		};
	};

	services.cliphist.enable = true;

	services.udiskie = {
		enable = true;
		automount = true;
		tray = "always";
	};

	programs.git = {
		enable = true;
		settings.user = {
			name = "Hamza";
			email = "82454201+mham-z@users.noreply.github.com";
		};
	};

	programs.nix-your-shell = {
		enable = true;
		enableZshIntegration = true;
		nix-output-monitor.enable = true;
	};

	home.pointerCursor = {
		gtk.enable = true;
		x11.enable = true;
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

	xdg.enable = true;
	xdg.terminal-exec = {
		enable = true;
		settings = {
			default = ["foot.desktop"];
		};
	};

	home.sessionVariables = {
		TERMINAL = "foot";
	};
}
