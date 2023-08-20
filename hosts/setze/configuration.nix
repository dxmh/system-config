{config, ...}: {
  homebrew.casks = [
    "discord"
    "element"
    "signal"
    "zoom"
  ];

  home-manager.users.${config.hxy.base.mainUser} = {
    # SSH client configuration (~/.ssh/config)
    programs.ssh = {
      enable = true;
      matchBlocks = {
        "*" = {
          extraOptions.UseKeychain = "yes";
          identitiesOnly = true;
        };
        "setze-vm s" = {
          extraOptions.AddKeysToAgent = "yes";
          forwardAgent = true;
          hostname = "setze-vm";
          identityFile = "~/.ssh/id_ed25519";
          user = "dom";
        };
        "thebox b" = {
          extraOptions.AddKeysToAgent = "no";
          forwardAgent = false;
          hostname = "thebox.int.hxy.io";
          identityFile = "~/.ssh/id_ed25519";
          user = "dom";
        };
      };
    };
  };

  hxy.base = {
    enable = true;
    stateVersion = {
      home-manager = "22.05";
      nix-darwin = 4;
    };
  };
  hxy.git.enable = true;
  hxy.helix.enable = true;
  hxy.sops-tools.enable = true;
  hxy.window-management.calendars = "19F3F933-3ADA-48D2-B960-FEE78FF854E2,20177754-749A-451E-8245-0415CEE96655";
}
