{
  mainUser,
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

    # Allow these users to specify additional binary caches:
    settings.trusted-users = [
      "@wheel" # Linux
      "@admin" # macOS
    ];
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
    gnumake
    htop
    prettyping
    tldr
    vim
  ];

  environment.variables = {
    EDITOR = "vim";
  };

  programs.fish.enable = true;
}
