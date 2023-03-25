{
  description = "System configuration";

  inputs = {
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    helix.url = "github:helix-editor/helix";
    helix.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    darwin,
    helix,
    home-manager,
    nixpkgs,
    nixpkgs-unstable,
    self,
    sops-nix,
  }: let
    mkSystem = import ./lib/mkSystem.nix;
    overlays = [
      (final: prev: {
        git-open = nixpkgs-unstable.legacyPackages.${prev.system}.git-open;
        helix = helix.packages.${prev.system}.default;
        nil = nixpkgs-unstable.legacyPackages.${prev.system}.nil;
        fish = nixpkgs-unstable.legacyPackages.${prev.system}.fish;
      })
    ];
  in {
    darwinConfigurations.setze = mkSystem "setze" {
      inherit self overlays;
      system = "aarch64-darwin";
    };

    darwinConfigurations.cbd = mkSystem "cbd" {
      inherit self overlays;
      system = "x86_64-darwin";
    };

    nixosConfigurations.cbd-vm = mkSystem "cbd-vm" {
      inherit self overlays;
      system = "x86_64-linux";
    };

    nixosConfigurations.setze-vm = mkSystem "setze-vm" {
      inherit self overlays;
      system = "aarch64-linux";
    };

    nixosConfigurations.thebox = mkSystem "thebox" {
      inherit self overlays;
      system = "x86_64-linux";
    };

    formatter.aarch64-darwin =
      nixpkgs.legacyPackages.aarch64-darwin.alejandra;
  };
}
