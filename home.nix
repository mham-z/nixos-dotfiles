{config, pkgs, ...}: {
	home.stateVersion = "26.05";

	home.packages = with pkgs; [
		dmenu
		bluetui
		cava
		cmd-polkit
		udiskie
		wl-clipboard
		obs-studio
		
		noto-fonts
		noto-fonts-color-emoji
		nerd-fonts.adwaita-mono
		nerd-fonts.symbols-only
		nerd-fonts.noto
	];
	fonts.fontconfig.enable = true;

	imports = [
		./packages/sway/sway.nix
		./packages/waybar/waybar.nix
		./packages/tofi/tofi.nix
		./packages/mako/mako.nix
	];

	services.flameshot.enable = true;
	services.cliphist.enable = true;

	services.wlsunset = {
		enable = true;
		latitude = 25;
		longitude = 67;
		systemdTarget = "graphical-session.target";
	};

	services.udiskie = {
		enable = true;
		automount = true;
		tray = "always";
	};

	programs.foot = {
		enable = true;
		
		settings = {
			main = {
				font = "NotoSansM Nerd Font:size=12";
				font-size-adjustment = 1;
				pad = "0x0 center-when-maximized-and-fullscreen";
				resize-by-cells = false;
				resize-keep-grid = false;
			};

			bell = {
				system = "yes";
				urgent = "yes";
				notify = "yes";
				visual = "no";
			};

			# Rosé Pine Color Palette
			colors-dark = {
				background = "191724";
				foreground = "e0def4";
				regular0 = "26233a";
				regular1 = "eb6f92";
				regular2 = "9ccfd8";
				regular3 = "f6c177";
				regular4 = "31748f";
				regular5 = "c4a7e7";
				regular6 = "ebbcba";
				regular7 = "e0def4";
				bright0  = "47435d";
				bright1  = "ff98ba";
				bright2  = "c5f9ff";
				bright3  = "ffeb9e";
				bright4  = "5b9ab7";
				bright5  = "eed0ff";
				bright6  = "ffe5e3";
				bright7  = "fefcff";
				flash    = "f6c177";
				cursor   = "191724 e0def4";
			};
		};
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
