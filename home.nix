{pkgs, lib, ...}: {
	home.stateVersion = "26.05";

	home.packages = with pkgs; [
		home-manager

		cava
		gh
		cmd-polkit
		udiskie
		wlsunset
		wl-clipboard
		wayvnc
		scrcpy
		ripgrep
		fd
		alarm-clock-applet
		pastel
		nomacs

		kdePackages.dolphin
		kdePackages.dolphin-plugins
		kdePackages.baloo
		kdePackages.kservice
		kdePackages.breeze
		kdePackages.breeze-icons
		kdePackages.qqc2-desktop-style
		kdePackages.qtstyleplugin-kvantum
		libsForQt5.qtstyleplugin-kvantum
		kdePackages.kde-cli-tools
		kdePackages.kio-extras

		wineWow64Packages.stable
		winetricks

		thunderbird
		bluetui
		aseprite
		krita
		inkscape
		blender
		vlc
		peazip

		prismlauncher
		heroic

		xournalpp
		obsidian
		texstudio
		libreoffice-still
		(texlive.combine {
			inherit (texlive) scheme-medium standalone scontents;
		})
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
		./modules/neovim/neovim.nix
		./modules/autostart.nix
	];
	
	home.activation.regenerateSycoca = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
		run ${pkgs.kdePackages.kservice}/bin/kbuildsycoca6 --noincremental
	'';

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
		settings.credential.helper = "${pkgs.gh}/bin/gh auth git-credential";
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
	
	xdg.enable = true;
	xdg.terminal-exec = {
		enable = true;
		settings = {
			default = ["foot.desktop"];
		};
	};

	 xdg.userDirs = {
		enable = true;
		createDirectories = true;
	};

	home.sessionVariables = {
		TERMINAL = "foot";
		GDK_CORE_DEVICE_EVENTS = "1";
		GTK_USE_PORTAL = "1";
		QT_QPA_PLATFORMTHEME = "kvantum";
		QT_STYLE_OVERRIDE = "kvantum";
		QT_QPA_PLATFORM = "wayland;xcb";
		XDG_MENU_PREFIX = "plasma-"; 
	};

	qt = {
		enable = true;
		platformTheme.name = "kvantum";
		style.name = "kvantum";
	};
}
