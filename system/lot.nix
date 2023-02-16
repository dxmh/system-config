{
  pkgs,
  user,
  ...
}: {
  imports = [./darwin.nix];

  environment = {
    systemPackages = [
      pkgs.docker-client
    ];
    variables = {
      DOCKER_HOST = "ssh://prl-vm";
    };
  };

  homebrew.casks = [
    "discord"
    "element"
    "google-chrome"
    "parallels"
    "signal"
    "slack"
    "syncthing"
    "utm"
    "zoom"
  ];

  # Configuration for building NixOS VM from macOS
  nix = {
    distributedBuilds = true;
    buildMachines = [
      # These machines must be non-interactively accessible to the root user
      {
        hostName = "prl-vm";
        system = "aarch64-linux";
        sshUser = "dom";
        sshKey = "/Users/${user}/.ssh/id_ed25519_nixbuilder";
      }
    ];
    extraOptions = ''
      builders-use-substitutes = true
    '';
  };

  # SSH client configuration (~/.ssh/config)
  home-manager.users.${user}.programs.ssh = {
    enable = true;
    matchBlocks = {
      "*" = {
        extraOptions = {
          "UseKeychain" = "yes"; # Store passwords in the macOS keychain
          "AddKeysToAgent" = "no";
        };
        identitiesOnly = true;
      };
      "thebox b" = {
        hostname = "thebox.int.hxy.io";
        identityFile = "~/.ssh/id_ed25519_thebox";
        user = "dom";
      };
      "parallels-vm" = {
        hostname = "prl-vm.shared"; # Parallels puts machine name in /etc/hosts
        identityFile = "~/.ssh/id_ed25519";
        user = "dom";
      };
      "qemu-vm" = {
        hostname = "127.0.0.1";
        identityFile = "~/.ssh/id_ed25519";
        port = 2022;
        user = "dom";
      };
    };
  };
}
