{
  pkgs,
  platform,
  ...
}: {
  imports = [./${platform}.nix];

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
      warn-dirty = false
    '';
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
    package = pkgs.nixVersions.stable;
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true; # for packages that don't specifically state aarch64 compatibility
  };

  hxy.kitty.enable = true;

  environment.systemPackages = with pkgs; [
    cachix
    coreutils
    dig
    exa
    fd
    git
    gnumake
    htop
    prettyping
    speedtest-cli
    tldr
    vim
  ];

  environment.variables = {
    EDITOR = "${pkgs.helix}/bin/hx";
  };

  hxy.fish.enable = true;
}