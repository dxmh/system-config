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
    EXA_ICON_SPACING = "2";
    FZF_DEFAULT_COMMAND = "${pkgs.ripgrep}/bin/rg --files --hidden --glob !.git/";
    FZF_DEFAULT_OPTS = "--color=light";
    MANPAGER = "sh -c 'col -bx | ${pkgs.bat}/bin/bat -l man -p'";
    SHELL = "${pkgs.fish}/bin/fish";
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

  programs.exa = {
    enable = true;
    enableAliases = false;
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
      ".direnv"
    ];
  };

  programs.kitty = {
    enable = true; # Ensure kitty is always available for kittens over SSH
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
      ./fish.nix
      ./helix.nix
    ]
    ++ (lib.lists.optionals isDarwin [
      ./kitty.nix
    ]);
}
