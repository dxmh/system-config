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
    settings = {
      substituters = [
        "https://dxmh.cachix.org/"
        "https://helix.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "dxmh.cachix.org-1:mxvbwbVG4qos714NloY6lzrM1lTEO1lHVcJVF1Ngyic="
        "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true; # for packages that don't specifically state aarch64 compatibility
  };

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

  hxy.fish.enable = true;
  hxy.kitty.enable = true;
}
