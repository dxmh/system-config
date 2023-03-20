{
  description = "System configuration";

  inputs = {
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    helix.url = "github:helix-editor/helix";
    helix.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    darwin,
    helix,
    home-manager,
    nix-index-database,
    nixpkgs,
    nixpkgs-unstable,
    self,
    sops-nix,
  }: let
    mkSystem = import ./lib/mkSystem.nix;
    overlays = [
      (final: prev: {
        helix = helix.packages.${prev.system}.default;
        nil = nixpkgs-unstable.legacyPackages.${prev.system}.nil;
      })
    ];
  in {
    darwinConfigurations.setze = mkSystem "setze/darwin.nix" {
      inherit self overlays;
      stateVersion.home = "22.05";
      stateVersion.system = 4;
      system = "aarch64-darwin";
      mainUser = "dom";
    };

    darwinConfigurations.cbdd = mkSystem "cbd/x86_64-darwin.nix" {
      inherit self overlays;
      stateVersion.home = "22.05";
      stateVersion.system = 4;
      system = "x86_64-darwin";
      mainUser = "dom.hay";
    };

    nixosConfigurations.cbda = mkSystem "cbd/aarch64-linux.nix" {
      inherit self overlays;
      stateVersion.home = "22.11";
      stateVersion.system = "22.11";
      system = "aarch64-linux";
      mainUser = "dom";
    };

    nixosConfigurations.cbdx = mkSystem "cbd/x86_64-linux.nix" {
      inherit self overlays;
      stateVersion.home = "22.11";
      stateVersion.system = "22.11";
      system = "x86_64-linux";
      mainUser = "dom";
    };

    nixosConfigurations.setze-vm = mkSystem "setze/configuration.nix" {
      inherit self overlays;
      stateVersion.home = "22.11";
      stateVersion.system = "22.11";
      system = "aarch64-linux";
      mainUser = "dom";
    };

    nixosConfigurations.thebox = mkSystem "thebox/configuration.nix" {
      inherit self;
      overlays = [];
      stateVersion.home = "22.11";
      stateVersion.system = "22.11";
      system = "x86_64-linux";
      mainUser = "dom";
    };

    formatter.aarch64-darwin =
      nixpkgs.legacyPackages.aarch64-darwin.alejandra;
  };

  nixConfig = {
    extra-substituters = [
      "https://dxmh.cachix.org/"
      "https://helix.cachix.org"
    ];
    extra-trusted-public-keys = [
      "dxmh.cachix.org-1:mxvbwbVG4qos714NloY6lzrM1lTEO1lHVcJVF1Ngyic="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
    ];
  };
}
