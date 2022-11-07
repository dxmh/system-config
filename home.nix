{ pkgs, lib, config, ... }: {

  home.stateVersion = "22.05";

  home.activation = {
    reloadKittyConf = lib.hm.dag.entryAfter ["writeBoundary"] ''
      killall -SIGUSR1 kitty || true
    '';
  };

  home.packages = with pkgs; [
    awscli2
    coreutils
    diceware
    fzf
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
    FZF_DEFAULT_COMMAND = "rg --files --hidden --glob !.git/";
    FZF_DEFAULT_OPTS = "--color=light";
    MANPAGER = "sh -c 'col -bx | ${pkgs.bat}/bin/bat -l man -p'";
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "OneHalfLight";
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
    difftastic = {
      enable = true;
    };
  };

  programs.kitty = {
    enable = true;
    settings = {
      shell = "${pkgs.fish}/bin/fish";
    };
    darwinLaunchOptions = [
      "--title='kitty'"
    ];
    extraConfig = builtins.readFile ./dotfiles/kitty.conf;
    theme = "One Half Light";
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
      character.error_symbol = "[\\$](bold red)";
      character.success_symbol = "[\\$](bold grey)";
      docker_context.disabled = true;
      git_branch.truncation_length = 24;
      git_status.format = "$staged$modified$untracked";
      git_status.modified = "[∗ ](bold red)";
      git_status.staged = "[∗ ](bold green)";
      git_status.untracked = "[∗ ](bold blue)";
      line_break.disabled = false;
      nodejs.disabled = true;
      php.disabled = true;
      python.symbol = " ";
      status.disabled = false;
      time.disabled = true;
      username.disabled = true;
      vagrant.disabled = true;
    };
  };

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      editorconfig-vim
      fugitive-gitlab-vim
      onehalf
      starsearch-vim
      vim-commentary
      vim-eunuch
      vim-fubitive
      vim-fugitive
      vim-nix
      vim-repeat
      vim-rhubarb
      vim-rsi
      vim-sensible
      vim-shellcheck
      vim-speeddating
      vim-surround
      vim-terraform
      vim-unimpaired
      vim-vinegar
      # neovim specific:
      gitsigns-nvim
      plenary-nvim
      telescope-nvim
    ];
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  # Cannot use home.progams.neovim.extraConfig due to this:
  # https://github.com/nix-community/home-manager/pull/3233#issuecomment-1279914732
  home.file.".config/nvim/init.vim" = {
    source = ./dotfiles/vimrc;
  };

  home.file.".hammerspoon/init.lua" = {
    source = ./dotfiles/hammerspoon.lua;
  };

  home.file.".config/kitty/smart_scroll.py" = {
    source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/yurikhan/kitty-smart-scroll/8aaa91/smart_scroll.py";
      sha256 = "sha256:0p6x51gf4m2r61w894cvzhy6cmvzmadz0jbvvj0clcvq1vh9kc63";
    };
  };

  # Alternative kitty icon
  # https://sw.kovidgoyal.net/kitty/faq/#i-do-not-like-the-kitty-icon
  home.file.".config/kitty/kitty.app.png" = {
    source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/samholmes/whiskers/89bdb2/whiskers-tokyo.png";
      sha256 = "sha256:1jdldcqbdr6ccnppq6pfm925xinzm6vfiv5q3cx1b4cpg14zax83";
    };
    onChange = ''
      rm /var/folders/*/*/*/com.apple.dock.iconcache; killall Dock
    '';
  };

}
