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
    "signal"
    "slack"
    "zoom"
  ];

  home-manager.users.${user} = {
    # SSH client configuration (~/.ssh/config)
    programs.ssh = {
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
        "utm-vm" = {
          hostname = "10.211.56.2";
          identityFile = "~/.ssh/id_ed25519";
          user = "dom";
        };
      };
    };
  };
}
