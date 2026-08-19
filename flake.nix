{
	description = "personal config";
	
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

		nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

		nixcord.url = "github:4evy/nixcord";

		home-manager.url = "github:nix-community/home-manager/release-26.05";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";

		vscode-insiders.url = "github:auguwu/vscode-insiders-nix";
		vscode-insiders.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = {self, nixpkgs, home-manager, vscode-insiders, ...}@inputs: {
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = {inherit inputs;}; 
			modules = [
				./configuration.nix {
					nixpkgs.config.allowUnfree = true;
					nixpkgs.overlays = [vscode-insiders.overlays.default];
				}

				home-manager.nixosModules.home-manager {
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.extraSpecialArgs = {inherit inputs;};
					home-manager.users.hamza = import ./home.nix;
				}
			];
		};

		homeConfigurations.hamza = home-manager.lib.homeManagerConfiguration {
			pkgs = nixpkgs.legacyPackages.x86_64-linux;
			extraSpecialArgs = {inherit inputs;};
			modules = [
				./home.nix
				{
					home.username = "hamza";
					home.homeDirectory = "/home/hamza";
					nixpkgs.config.allowUnfree = true;
					nixpkgs.overlays = [vscode-insiders.overlays.default];
				}
			];
		};
	};
}
