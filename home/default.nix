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

  # http://starship.rs/config/
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      aws.disabled = true;
      character.error_symbol = "[\⟩](red)";
      character.success_symbol = "[\⟩](dimmed white)";
      docker_context.disabled = true;
      format = "\$all\$hostname\$status\$character";
      git_status.disabled = true;
      git_branch.symbol = " ";
      hostname = {
        ssh_only = false;
        ssh_symbol = "";
        format = "[\$ssh_symbol\$hostname](\$style) ";
        style = "dimmed white";
      };
      line_break.disabled = false;
      nodejs.disabled = true;
      package.disabled = true;
      php.disabled = true;
      python.symbol = " ";
      status.disabled = false;
      status.symbol = "⨯";
      time.disabled = true;
      username.disabled = true;
      vagrant.disabled = true;
    };
  };
}
