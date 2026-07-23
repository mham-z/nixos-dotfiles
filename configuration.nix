{ config, lib, pkgs, ... }: {
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
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
		open = true;
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
	
	users.users.hamza = {
		isNormalUser = true;
		extraGroups = ["wheel" "video" "input"];
		packages = with pkgs; [
			tree
		];
	};

	programs.sway = {
		enable = true;
		wrapperFeatures.gtk = true;
	};

	services.displayManager.ly = {
		enable = true;
		settings.animate = true;
	};

	environment.sessionVariables = {
		XDG_SESSION_TYPE = "wayland";
		SWAY_UNSUPPORTED_GPU = "1";
		__GLX_VENDOR_LIBRARY_NAME = "nvidia";
		GBM_BACKEND = "nvidia-drm";
		WLR_NO_HARDWARE_CURSORS = "1";
	};

	xdg.portal = {
		enable = true;
		wlr.enable = true;
		extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
	};
	services.dbus.enable = true;
	services.seatd.enable = true;
	services.tuned.enable = true;
	services.tuned.ppdSupport = true;
	services.libinput.enable = true;
	services.gnome.gnome-keyring.enable = true;
	security.polkit.enable = true;
		services.pipewire = {
		enable = true;
		pulse.enable = true;
	};

	environment.systemPackages = with pkgs; [
		vim
		wget
		pciutils
		bluetui
		git
	];

	programs.mtr.enable = true;
	programs.gnupg.agent = {
	  enable = true;
	  enableSSHSupport = true;
	};

	services.openssh.enable = true;
	services.openssh.openFirewall = true; 

	networking.firewall.allowedTCPPorts = [];
	networking.firewall.allowedUDPPorts = [];

	system.stateVersion = "26.05"; # DO NOT CHANGE
}

