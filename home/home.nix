{
  pkgs,
  lib,
  config,
  isDarwin,
  ...
}: {
  home.stateVersion = "22.05";

  home.activation = {
    updateBatCache = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ${pkgs.bat}/bin/bat cache --build
    '';
  };

  home.packages = with pkgs; [
    awscli2
    coreutils
    diceware
    fzf
    git-open
    jless
    jq
    qrencode
    ripgrep
    shellcheck
    ssm-session-manager-plugin
    terraform
    tree
    (writeShellScriptBin "ssm" (builtins.readFile ./dotfiles/ssm.sh))
  ];

  home.sessionVariables = {
    DIRENV_LOG_FORMAT = ""; # https://github.com/direnv/direnv/issues/68
    EDITOR = "hx";
    FZF_DEFAULT_COMMAND = "rg --files --hidden --glob !.git/";
    FZF_DEFAULT_OPTS = "--color=light";
    MANPAGER = "sh -c 'col -bx | ${pkgs.bat}/bin/bat -l man -p'";
    BAT_THEME = "Catppuccin"; # also used by delta
  };

  programs.bat = {
    enable = true;
    themes = {
      Catppuccin = builtins.readFile (pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
          sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
        }
        + "/Catppuccin-mocha.tmTheme");
    };
  };

  programs.direnv = {
    enable = true;
    config = {
      global = {
        disable_stdin = true;
      };
    };
  };

  programs.fish = {
    enable = true;
    shellInit = ''
      # Disable welcome message
      set fish_greeting
      # Enable z (https://github.com/skywind3000/z.lua)
      ${pkgs.z-lua}/bin/z --init fish | source
      set -gx _ZL_CD cd
    '';
    interactiveShellInit = lib.strings.concatStrings (lib.strings.intersperse "\n" [
      (builtins.readFile ./dotfiles/config.fish)
      "set -g SHELL ${pkgs.fish}/bin/fish"
    ]);
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
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
    ];
  };

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
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
      time.disabled = true;
      username.disabled = true;
      vagrant.disabled = true;
    };
  };

  imports =
    [
      ./helix.nix
    ]
    ++ (lib.lists.optionals isDarwin [
      ./hammerspoon.nix
      ./kitty.nix
    ]);
}
