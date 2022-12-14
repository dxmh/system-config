# This flake is based on the examples below:
# - https://github.com/LnL7/nix-darwin/blob/master/modules/examples/flake.nix
# - https://rycee.gitlab.io/home-manager/index.html#sec-flakes-nix-darwin-module

{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, darwin, nixpkgs, nixpkgs-unstable, home-manager }: {

    darwinConfigurations = {

      lot = darwin.lib.darwinSystem rec {
        system = "aarch64-darwin";
        specialArgs = { isWork = false; isDarwin = true; };
        modules = [
          ./system/configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.users."dom" = import ./home/home.nix;
            home-manager.extraSpecialArgs = {
              isDarwin = true;
              unstable = nixpkgs-unstable.legacyPackages.${system};
            };
          }
        ];
      };

      cbd = darwin.lib.darwinSystem rec {
        system = "x86_64-darwin";
        specialArgs = { isWork = true; isDarwin = true; };
        modules = [
          ./system/configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.users."dom.hay" = import ./home/home.nix;
            home-manager.extraSpecialArgs = {
              isDarwin = true;
              unstable = nixpkgs-unstable.legacyPackages.${system};
            };
          }
        ];
      };

    };

    nixosConfigurations = {

      parallels-vm = nixpkgs.lib.nixosSystem rec {
        system = "aarch64-linux";
        specialArgs = { isWork = false; isDarwin = false; };
        modules = [
          ./hardware/parallels.nix
          ./system/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.users."dom" = import ./home/home.nix;
            home-manager.extraSpecialArgs = {
              isDarwin = false;
              unstable = nixpkgs-unstable.legacyPackages.${system};
            };
          }
        ];
      };

    };

  };
}
