{
  pkgs,
  mainUser,
  ...
}: {
  imports = [
    ./darwin.nix
    ../home/sops.nix
  ];

  environment = {
    systemPackages = [
      pkgs.docker-client
    ];
    variables = {
      DOCKER_HOST = "ssh://utm-vm";
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

  home-manager.users.${mainUser} = {
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
        "utm-vm" = {
          hostname = "10.211.56.2";
          identityFile = "~/.ssh/id_ed25519";
          user = "dom";
        };
      };
    };
  };
}
