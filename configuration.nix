{config, lib, pkgs, ...}: {
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	nix.settings.auto-optimise-store = true;

	nix.gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 30d";
	};

	imports = [./hardware-configuration.nix];

	boot.loader.systemd-boot.enable = false;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.loader.efi.efiSysMountPoint = "/boot";

	boot.loader.grub = {
		enable = true;
		efiSupport = true;
		device = "nodev";
		useOSProber = true;
	};

	boot.kernelPackages = pkgs.linuxPackages_latest;
	boot.kernel.sysctl."kernel.sysrq" = 502;

	networking.networkmanager.enable = true;
	time.timeZone = "Asia/Karachi";
	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;

	hardware.graphics = {
		enable = true;
		enable32Bit = true;
	};
	services.xserver.videoDrivers = [ "nvidia" ];
	hardware.nvidia = {
		modesetting.enable = true;
		powerManagement.enable = true;
		powerManagement.finegrained = true;
		open = false;
		nvidiaSettings = true;
		prime = {
			offload = {
				enable = true;
				enableOffloadCmd = true;
			};
			intelBusId = "PCI:0:2:0";
			nvidiaBusId = "PCI:1:0:0";
		};
	};

	environment.sessionVariables = {
		EDITOR = "vim";
		VISUAL = "vim";
		PAGER = "less";
		
		XDG_SESSION_DESKTOP = "sway";
		XDG_CURRENT_DESKTOP = "sway";
		XDG_SESSION_TYPE = "wayland";
		SWAY_UNSUPPORTED_GPU = "1";
		WLR_NO_HARDWARE_CURSORS = "1";

		__GLX_VENDOR_LIBRARY_NAME = "nvidia";
		GBM_BACKEND = "nvidia-drm";
	};

	environment.etc."issue".text = builtins.concatStringsSep "\n" [
		"Welcome to NixOS ${config.system.nixos.version} (\\m) - \\l"
		"Kernel version \\r"
		"Default specialization" "" ""
	];

	specialisation."iGPU-Only".configuration = {
		environment.etc."issue".text = lib.mkForce (builtins.concatStringsSep "\n" [
			"Welcome to NixOS ${config.system.nixos.version} (\\m) - \\l"
			"Kernel version \\r"
			"iGPU-only specialization" "" ""
		]);


		system.nixos.tags = ["igpu-only"];
		services.xserver.videoDrivers = ["modesetting"];
		hardware.nvidia.nvidiaSettings = lib.mkForce false;
		boot.blacklistedKernelModules = ["nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" "nouveau"];

		services.udev.extraRules = ''
			ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{remove}="1"
			ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{remove}="1"
			ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{remove}="1"
			ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", ATTR{remove}="1"
		'';

		environment.sessionVariables = {
			__GLX_VENDOR_LIBRARY_NAME = lib.mkForce null;
			GBM_BACKEND = lib.mkForce null;
		};
	};

	users.groups.keyd = {};
	users.users.hamza = {
		isNormalUser = true;
		extraGroups = ["wheel" "video" "input" "keyd" "libvirtd"];
		packages = with pkgs; [
			tree
		];
		shell = pkgs.zsh;
		useDefaultShell = false;
	};

	programs.sway = {
		enable = true;
		wrapperFeatures.gtk = true;
	};

	programs.uwsm = {
		enable = true;

		waylandCompositors.sway = {
			prettyName = "Sway (UWSM)";
			comment = "Sway compositor managed by UWSM";
			binPath = "${pkgs.sway}/bin/sway";
		};
	};

	xdg.portal = {
		enable = true;
		wlr.enable = true;
		extraPortals = [pkgs.xdg-desktop-portal-gtk];
		
		wlr.settings = {
			screencast = {
				max_fps = 60;
				exec_before = "notify-send -h string:x-canonical-private-synchronous:screencast-alert \"Screencast\" \"Screencast started\"";
				exec_after = "notify-send -h string:x-canonical-private-synchronous:screencast-alert \"Screencast\" \"Screencast ended\"";
				chooser_type = "dmenu";
				chooser_cmd = "${pkgs.tofi}/bin/tofi -c ~/.config/tofi/xdp-wlr";
			};
		};

		config.common.default = "gtk";
	};

	services.dbus.enable = true;
	services.seatd.enable = true;
	services.tuned.enable = true;
	services.tuned.ppdSupport = true;
	services.libinput.enable = true;
	services.udisks2.enable = true;
	services.gvfs.enable = true;
	services.gnome.gnome-keyring.enable = true;
	services.flatpak.enable = true;
	programs.dconf.enable = true;

	security.polkit.enable = true;
		services.pipewire = {
		enable = true;
		pulse.enable = true;
	};

	services.keyd = {
		enable = true;
		keyboards = {
			default = {
				ids = ["*"];
				settings.main.capslock = "layer(meta)";
			};
		};
	};
	systemd.services.keyd.serviceConfig.CapabilityBoundingSet = ["CAP_SETGID"];

	hardware.opentabletdriver.enable = true;
  hardware.opentabletdriver.daemon.enable = true;

	environment.systemPackages = with pkgs; [
		(vim.overrideAttrs (oldAttrs: {
			postInstall = (oldAttrs.postInstall or "") + ''
				rm $out/share/applications/gvim.desktop
			'';
		}))
		wget
		lm_sensors
		pciutils
		keyd
		powertop
		wlock
		tuigreet
		jq
		libqalculate
		htop
		lsof
		aria2
		python3

		dnsmasq

		(pkgs.writeScriptBin "dgpu-mode" ''
		#!/bin/sh
		sudo modprobe think-lmi
		echo "DiscreteGfx" | sudo tee /sys/class/firmware-attributes/thinklmi/attributes/GraphicsDevice/current_value
		sudo ${pkgs.grub2}/bin/grub-reboot 0
		echo "Discrete graphics mode is active. You may reboot now for the changes to take effect."
		'')

		(pkgs.writeScriptBin "igpu-mode" ''
		#!/bin/sh
		sudo modprobe think-lmi
		echo "SwitchableGfx" | sudo tee /sys/class/firmware-attributes/thinklmi/attributes/GraphicsDevice/current_value
		sudo ${pkgs.grub2}/bin/grub-reboot 1
		echo "Integrated graphics mode is active. You may reboot now for the changes to take effect."
		'')
	];

	fonts.packages = with pkgs; [
		noto-fonts
		noto-fonts-color-emoji
		nerd-fonts.adwaita-mono
		nerd-fonts.symbols-only
		nerd-fonts.noto
	];
	fonts.fontconfig.enable = true;

	programs.obs-studio = {
		enable = true;
		package = (pkgs.obs-studio.override {
			cudaSupport = true;
		});
	};

	programs.steam = {
		enable = true;
		remotePlay.openFirewall = true;
		dedicatedServer.openFirewall = true;
		localNetworkGameTransfers.openFirewall = true;
	};

	programs.zsh = {
		enable = true;
		enableCompletion = true; 
		autosuggestions.enable = true;
		syntaxHighlighting.enable = true;

		loginShellInit = ''
		if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = "1" ] && uwsm check may-start; then
			exec uwsm start sway
		fi
		'';

		interactiveShellInit = ''
			bindkey -e
			bindkey "\e[1;5D" backward-word
			bindkey "\e[1;5C" forward-word
		'';

		shellAliases = {
			la = "ls -lAh";
			gclone = "git clone --depth=1";
			root = "sudo -i";
			rs = "sudo nixos-rebuild switch --flake ~/dotfiles/#nixos";
			rb = "sudo nixos-rebuild boot --flake ~/dotfiles/#nixos";
			code = "code-insiders";
			dl = "aria2c -d ~/Downloads/aria2 --split=16";
		};

		setOptions = ["AUTOCD"];
	};

	programs.starship = {
			enable = true;
			settings = {
				add_newline = false;
			};
	};

	security.wrappers.wlock = {
		enable = true;
		owner = "root";
		group = "root";
		setuid = true;
		setgid = false;
		source = "${pkgs.wlock}/bin/wlock";
	};

	security.sudo.extraConfig = ''
		Defaults passprompt="sudo: authenticating for user %u: "
	'';

	programs.mtr.enable = true;
	programs.gnupg.agent = {
	  enable = true;
	  enableSSHSupport = true;
	};

	virtualisation.libvirtd = {
		enable = true;
		qemu.vhostUserPackages = with pkgs; [virtiofsd];
	};
	programs.virt-manager.enable = true;

	services.openssh.enable = true;
	services.openssh.openFirewall = true; 

	networking.firewall.allowedTCPPorts = [5900];
	networking.firewall.allowedUDPPorts = [];
	networking.firewall.trustedInterfaces = ["virbr0"];

	system.stateVersion = "26.05"; # DO NOT CHANGE
}

