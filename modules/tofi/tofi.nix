{pkgs, lib, ...}:

let
	allFiles = builtins.attrNames (builtins.readDir ./.);

	stowFiles = builtins.filter (name: 
		name != "tofi.nix" && 
		name != "font" &&
		!lib.hasSuffix ".nix" name
	) allFiles;

	stowEntries = builtins.listToAttrs (builtins.map (filename: {
		name = "tofi/${filename}";
		value = {source = ./. + "/${filename}";};
	}) stowFiles);

	fontEntry = {
		"tofi/font" = {
			text = ''
				font = "${pkgs.noto-fonts}/share/fonts//noto/NotoSansMono.ttf"
				${builtins.readFile ./font}
			'';
		};
	};

in {
	home.packages = [
		(pkgs.tofi.overrideAttrs (oldAttrs: rec {
			version = "unstable";
			src = pkgs.fetchFromGitHub {
				owner = "philj56";
				repo = "tofi";
				rev = "master";
				hash = "sha256-OD56rwDrXgb5pg85sT5v+zl9A1/sfn77PBSG4gT76bE="; 
			};
		}))
	];

	xdg.configFile = stowEntries // fontEntry;
}
