{mainUser, ...}: {
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

  hxy.helix.enable = true;
  hxy.sops-tools.enable = true;
}
