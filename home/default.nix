{stateVersion, ...}: {
  home.stateVersion = stateVersion.home;

  programs.git = {
    enable = true;
    extraConfig = {
      push.autoSetupRemote = true;
    };
    delta = {
      enable = true;
    };
    ignores = [
      ".DS_Store"
      ".direnv"
    ];
  };
}
