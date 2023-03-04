{
  pkgs,
  lib,
  ...
}: {
  programs.fish = {
    enable = true;
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
    interactiveShellInit = lib.strings.concatStrings (lib.strings.intersperse "\n" [
      ''
        # Enable z (https://github.com/skywind3000/z.lua):
        ${pkgs.z-lua}/bin/z --init fish | source; set -gx _ZL_CD cd
      ''
      (builtins.readFile ./dotfiles/config.fish)
    ]);
  };
}
