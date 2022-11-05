# This flake is based on the examples below:
# - https://github.com/LnL7/nix-darwin/blob/master/modules/examples/flake.nix
# - https://rycee.gitlab.io/home-manager/index.html#sec-flakes-nix-darwin-module

# Note that nix-darwin, home-manager (and Homebrew) need installing manually
# before this flake can be used.

{
  description = "nix-darwin system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, darwin, nixpkgs, home-manager }:
  let
    configuration = {
      nixpkgs.config.allowUnfree = true;
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      imports = [ ./darwin.nix ./brew.nix ];
    };
  in {
    darwinConfigurations = {

      lot = darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [
          configuration
          darwin.darwinModules.simple
          home-manager.darwinModules.home-manager
          { home-manager.users."dom" = import ./home.nix; }
        ];
      };

      cbd = darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [
          configuration
          darwin.darwinModules.simple
          home-manager.darwinModules.home-manager
          { home-manager.users."dom.hay" = import ./home.nix; }
        ];
      };

    };
  };
}
