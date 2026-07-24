{config, pkgs, ...}: {
	home.stateVersion = "26.05";

	home.packages = with pkgs; [
		foot
		dmenu
		bluetui
		cava
		cmd-polkit
		
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
	];

	services.flameshot.enable = true;

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
