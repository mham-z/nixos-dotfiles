{
	description = "personal config";
	
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

		home-manager.url = "github:nix-community/home-manager/release-26.05";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";

		vscode-insiders.url = "github:auguwu/vscode-insiders-nix";
		vscode-insiders.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = { self, nixpkgs, home-manager, vscode-insiders, ... }: {
		nixosConfigurations.hamza = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./configuration.nix {
					nixpkgs.config.allowUnfree = true;
					nixpkgs.overlays = [vscode-insiders.overlays.default];
				}

				home-manager.nixosModules.home-manager {
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.users.hamza = import ./home.nix;
				}
			];
		};
	};
}
