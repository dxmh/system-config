{
  pkgs,
  lib,
  ...
}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = lib.strings.concatStrings (lib.strings.intersperse "\n" [
      ''
        # Disable welcome message:
        set fish_greeting

        # Enable z (https://github.com/skywind3000/z.lua):
        ${pkgs.z-lua}/bin/z --init fish | source; set -gx _ZL_CD cd

        # Enable AWS CLI autocompletion (https://github.com/aws/aws-cli/issues/1079):
        complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'

        # Kitty shell integration (https://sw.kovidgoyal.net/kitty/shell-integration/#manual-shell-integration):
        if set -q KITTY_INSTALLATION_DIR
          set --global KITTY_SHELL_INTEGRATION enabled
          source "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_conf.d/kitty-shell-integration.fish"
          set --prepend fish_complete_path "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_completions.d"
        end
      ''
    ]);
    functions = {
      fish_title = "basename (prompt_pwd)";
    };
    shellAbbrs = {
      "." = "cd -";
      ".." = "cd ../";
      "..." = "cd ../../";
      ao = "aws-console -p";
      cat = "bat";
      d = "docker";
      dc = "docker-compose";
      eo = "$EDITOR .";
      kssh = "kitty +kitten ssh";
      m = "make -s";
      tfm = "terraform";
      vim = "hx";
      "g." = "git switch -";
      g = "git";
      gc = "git commit -v";
      gco = "git checkout";
      gcop = "git checkout -p";
      gcp = "git commit -v -p";
      gcpa = "git commit -v -p --amend";
      gd = "git diff";
      go = "git open";
      gs = "git status --short --untracked-files --branch";
      add = "git add";
      clone = "git clone";
      co = "git checkout";
      fetch = "git fetch --all";
      log = "git log";
      pull = "git pull";
      push = "git push";
      show = "git show";
      stash = "git stash";
    };
    shellAliases = {
      l = "exa --git --icons --level 1 --long --no-filesize --no-permissions --no-time --no-user --tree";
      ll = "l --level 2";
      lll = "l --level 3";
      llll = "l --level 999";
    };
  };

  home.file.".config/fish/themes/Catppuccin Mocha.theme" = {
    source = builtins.fetchurl {
      name = "CatppuccinMocha.theme"; # paths in nix store cannot contain spaces
      sha256 = "sha256:0hskfmwk09bchcs3rw9b29x2i30yr2q28mnbf9rjmmv3xdc0qy4d";
      url = "https://raw.githubusercontent.com/catppuccin/fish/b90966686068b5ebc9f80e5b90fdf8c02ee7a0ba/themes/Catppuccin%20Mocha.theme";
    };
  };

  home.activation = {
    setFishTheme = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ${pkgs.fish}/bin/fish -c 'yes | fish_config theme save "Catppuccin Mocha"'
    '';
  };
}
