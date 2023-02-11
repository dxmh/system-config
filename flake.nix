# This flake is based on the examples below:
# - https://github.com/LnL7/nix-darwin/blob/master/modules/examples/flake.nix
# - https://rycee.gitlab.io/home-manager/index.html#sec-flakes-nix-darwin-module

{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    helix.url = "github:helix-editor/helix/3b301a9d1d832d304ff109aa9f5eee025789b3e8";
  };

  outputs = { self, darwin, nixpkgs, home-manager, helix }: {

    darwinConfigurations.lot = darwin.lib.darwinSystem rec {
      system = "aarch64-darwin";
      specialArgs = { isWork = false; isDarwin = true; };
      modules = [
        ./system/configuration.nix
        ./system/docker-client.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.users."dom" = import ./home/home.nix;
          home-manager.extraSpecialArgs = {
            isDarwin = true;
            helix = helix.packages.${system};
          };
        }
      ];
    };

    darwinConfigurations.cbd = darwin.lib.darwinSystem rec {
      system = "x86_64-darwin";
      specialArgs = { isWork = true; isDarwin = true; };
      modules = [
        ./system/configuration.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.users."dom.hay" = import ./home/home.nix;
          home-manager.extraSpecialArgs = {
            isDarwin = true;
            helix = helix.packages.${system};
          };
        }
      ];
    };

    nixosConfigurations.parallels-vm = nixpkgs.lib.nixosSystem rec {
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
            helix = helix.packages.${system};
          };
        }
      ];
    };

    # See https://www.tweag.io/blog/2023-02-09-nixos-vm-on-macos/ for info.
    # This needs to be bootstrapped by building from macOS, using an existing
    # NixOS Linux machine as the builder...
    # nix run .#linuxVM --builders "ssh://me@remote-nixos aarch64-linux" --verbose
    nixosConfigurations.linuxVM = nixpkgs.lib.nixosSystem rec {
      system = "aarch64-linux";
      specialArgs = { isWork = false; isDarwin = false; };
      modules = [
        ./hardware/qemu.nix
        ./system/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.users."dom" = import ./home/home.nix;
          home-manager.extraSpecialArgs = {
            isDarwin = false;
            helix = helix.packages.${system};
          };
          virtualisation.vmVariant.virtualisation.host.pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        }
      ];
    };

    packages.aarch64-darwin.linuxVM = self.nixosConfigurations.linuxVM.config.system.build.vm;

  };

  nixConfig = {
    extra-substituters = ["https://dxmh.cachix.org/"];
    extra-trusted-public-keys = ["dxmh.cachix.org-1:mxvbwbVG4qos714NloY6lzrM1lTEO1lHVcJVF1Ngyic="];
  };

}
