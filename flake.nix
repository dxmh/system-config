{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    helix.url = "github:helix-editor/helix";
    helix.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    darwin,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    helix,
    sops-nix,
  }: let
    overlays = [
      (final: prev: {
        helix = helix.packages.${prev.system}.default;
        nil = nixpkgs-unstable.legacyPackages.${prev.system}.nil;
      })
    ];
  in {
    darwinConfigurations.lot = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = {user = "dom";};
      modules = [
        ./system/lot.nix
        home-manager.darwinModules.home-manager
        {nixpkgs.overlays = overlays;}
      ];
    };

    darwinConfigurations.cbd = darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      specialArgs = {user = "dom.hay";};
      modules = [
        ./system/cbd.nix
        home-manager.darwinModules.home-manager
        {nixpkgs.overlays = overlays;}
      ];
    };

    nixosConfigurations.utm-vm = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = {user = "dom";};
      modules = [
        ./system/utm.nix
        home-manager.nixosModules.home-manager
        {nixpkgs.overlays = overlays;}
      ];
    };

    nixosConfigurations.thebox-vm = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = {user = "dom";};
      modules = [
        ./system/thebox
        home-manager.nixosModules.home-manager
        sops-nix.nixosModules.sops
        {nixpkgs.overlays = overlays;}
      ];
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
