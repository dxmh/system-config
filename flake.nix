{
  description = "System configuration";

  inputs = {
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs";
    nur.url = "github:nix-community/NUR";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    darwin,
    home-manager,
    nixpkgs,
    nixpkgs-unstable,
    nur,
    self,
    sops-nix,
  }: let
    mkSystem = import ./lib/mkSystem.nix;
    overlays = [
      (final: prev: {
      })
    ];
  in {
    darwinConfigurations.setze = mkSystem "setze" {
      inherit self overlays;
      system = "aarch64-darwin";
    };

    nixosConfigurations.setze-vm = mkSystem "setze-vm" {
      inherit self overlays;
      system = "aarch64-linux";
    };

    nixosConfigurations.s6s-vm = mkSystem "s6s-vm" {
      inherit self overlays;
      system = "aarch64-linux";
    };

    nixosConfigurations.dln-vm = mkSystem "dln-vm" {
      inherit self overlays;
      system = "aarch64-linux";
    };

    nixosConfigurations.thebox = mkSystem "thebox" {
      inherit self overlays;
      system = "x86_64-linux";
    };

    nixosConfigurations.quinze = mkSystem "quinze" {
      inherit self overlays;
      system = "x86_64-linux";
    };

    nixosConfigurations.vint-i-u = mkSystem "vint-i-u" {
      inherit self overlays;
      system = "x86_64-linux";
    };

    formatter.aarch64-darwin =
      nixpkgs.legacyPackages.aarch64-darwin.alejandra;
  };
}
