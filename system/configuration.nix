{ lib, pkgs, isDarwin, ... }: {

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
      warn-dirty = false
    '';
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixVersions.stable;
    settings.auto-optimise-store = true;
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true; # for packages that don't specifically state aarch64 compatibility
  };

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
