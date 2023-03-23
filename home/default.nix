{
  lib,
  pkgs,
  stateVersion,
  ...
}: {
  home.stateVersion = stateVersion.home;

  home.activation = {
    updateBatCache = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ${pkgs.bat}/bin/bat cache --build >/dev/null
    '';
  };

  home.packages = with pkgs; [
    diceware
    fzf
    git-open
    jless
    jq
    qrencode
    ripgrep
    shellcheck
    terraform
  ];

  home.sessionVariables = {
    DIRENV_LOG_FORMAT = ""; # https://github.com/direnv/direnv/issues/68
    EDITOR = "${pkgs.helix}/bin/hx";
    EXA_ICON_SPACING = "1";
    FZF_DEFAULT_COMMAND = "${pkgs.ripgrep}/bin/rg --files --hidden --glob !.git/";
    FZF_DEFAULT_OPTS = "--color=light";
    MANPAGER = "sh -c 'col -bx | ${pkgs.bat}/bin/bat -l man -p'";
    BAT_THEME = "Visual Studio Dark+"; # also used by delta; see `bat --list-themes`
  };

  programs.bat = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    config = {
      global = {
        disable_stdin = true;
      };
    };
  };

  programs.exa = {
    enable = true;
    enableAliases = false;
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    # enableFishIntegration = config.hxy.fish.enable; # TODO
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

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
    # enableFishIntegration = config.hxy.fish.enable; # TODO
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    # enableFishIntegration = config.hxy.fish.enable; # TODO
    settings = {
      add_newline = false;
      aws.disabled = true;
      character.error_symbol = "[\⟩](red)";
      character.success_symbol = "[\⟩](dimmed white)";
      docker_context.disabled = true;
      format = "\$all\$hostname\$status\$character";
      git_status.disabled = true;
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

  imports = [
    ./helix.nix
  ];
}
