{ lib, pkgs, isDarwin, ... }: {

  nix.package = pkgs.nixVersions.stable;
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
  };
  nix.settings.auto-optimise-store = true;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
    warn-dirty = false
  '';

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true; # for packages that don't specifically state aarch64 compatibility

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  environment.variables = {
    EDITOR = "vim";
  };

  programs.fish.enable = true;

} // lib.optionalAttrs isDarwin {

  imports = [
    ./darwin.nix
  ];

}
