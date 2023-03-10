{
  pkgs,
  user,
  ...
}: {
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

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${user} = import ../home/home.nix;
  };

  environment.systemPackages = with pkgs; [
    cachix
    coreutils
    exa
    findutils
    gnumake
    htop
    vim
  ];

  environment.variables = {
    EDITOR = "vim";
  };

  programs.fish.enable = true;
}
