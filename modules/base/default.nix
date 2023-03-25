{
  pkgs,
  lib,
  config,
  platform,
  ...
}: {
  imports = [./${platform}.nix];

  options.hxy.base = {
    enable = lib.mkEnableOption "Enable base system configuration";
    mainUser = lib.mkOption {
      type = lib.types.str;
      default = "dom";
      description = "The primary user of the system";
    };
    flakeUri = lib.mkOption {
      type = lib.types.str;
      default = "github.com:dxmh/system-config";
      description = "Default NixOS flake to use";
    };
    stateVersion = {
      home-manager = lib.mkOption {
        # See https://nix-community.github.io/home-manager/release-notes.html
        type = lib.types.str;
        description = "Home Manager state version for this system";
      };
      nixos = lib.mkOption {
        # See https://github.com/NixOS/nixpkgs/blob/970402e6147c49603f4d06defe44d27fe51884ce/nixos/modules/misc/version.nix#L91C5-L92
        type = lib.types.str;
        description = "NixOS system state version for this system";
      };
      nix-darwin = lib.mkOption {
        # See https://github.com/LnL7/nix-darwin/blob/3db1d870b04b13411f56ab1a50cd32b001f56433/modules/system/version.nix#L35-L36
        type = lib.types.int;
        description = "nix-darwin system state version for this system";
      };
    };
  };

  config = lib.mkIf config.hxy.base.enable {
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
      bat
      cachix
      coreutils
      diceware
      dig
      direnv
      exa
      fd
      fzf
      gnumake
      htop
      jless
      jq
      nix-output-monitor
      prettyping
      ripgrep
      speedtest-cli
      tldr
      vim
    ];

    environment.variables = {
      BAT_THEME = "Visual Studio Dark+"; # also used by delta; see `bat --list-themes`
      DIRENV_LOG_FORMAT = ""; # https://github.com/direnv/direnv/issues/68
      MANPAGER = "sh -c 'col -bx | ${pkgs.bat}/bin/bat -l man -p'";
    };

    hxy.fish.enable = true;
    hxy.kitty.enable = true;

    # Configure the state version
    home-manager.users.${config.hxy.base.mainUser} = {
      home.stateVersion = config.hxy.base.stateVersion.home-manager;
    };
  };
}
