{stateVersion, ...}: {
  home.stateVersion = stateVersion.home;

  home.sessionVariables = {
    DIRENV_LOG_FORMAT = ""; # https://github.com/direnv/direnv/issues/68
  };

  programs.direnv = {
    enable = true;
    config = {
      global = {
        disable_stdin = true;
      };
    };
  };

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
