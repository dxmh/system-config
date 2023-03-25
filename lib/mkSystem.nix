name: {
  overlays,
  self,
  system,
}: let
  inherit (self) inputs;
  inherit (inputs.nixpkgs.lib) strings lists;
  platform = builtins.elemAt (strings.splitString "-" system) 1;
  systemBuilder =
    if (platform == "darwin")
    then inputs.darwin.lib.darwinSystem
    else inputs.nixpkgs.lib.nixosSystem;
in
  systemBuilder {
    inherit system;
    specialArgs = {inherit platform;};
    modules =
      [
        ../hosts/${name}/configuration.nix
        ../modules
        {
          nix.registry.nixpkgs.flake = inputs.nixpkgs;
          nix.registry.nixpkgs-unstable.flake = inputs.nixpkgs-unstable;
          nixpkgs.overlays = overlays;
        }
      ]
      ++ (lists.optionals (platform == "darwin") [
        inputs.home-manager.darwinModules.home-manager
      ])
      ++ (lists.optionals (platform == "linux") [
        inputs.home-manager.nixosModules.home-manager
        inputs.sops-nix.nixosModules.sops
      ]);
  }
