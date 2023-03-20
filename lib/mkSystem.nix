name: {
  mainUser,
  overlays,
  self,
  stateVersion,
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
    specialArgs = {inherit mainUser platform;};
    modules =
      [
        ../system/${name}
        {
          home-manager = {
            extraSpecialArgs = {inherit platform stateVersion;};
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${mainUser} = {
              imports = [
                ../home
                inputs.nix-index-database.hmModules.nix-index
              ];
            };
          };
          nix.registry = {
            nixpkgs.flake = inputs.nixpkgs;
            nixpkgs-unstable.flake = inputs.nixpkgs-unstable;
          };
          nixpkgs.overlays = overlays;
          system.stateVersion = stateVersion.system;
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
