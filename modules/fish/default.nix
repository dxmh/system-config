{
  config,
  lib,
  pkgs,
  mainUser,
  ...
}: {
  options.hxy.fish.enable = lib.mkEnableOption "Enable fish shell";

  config = lib.mkIf config.hxy.fish.enable {
    programs.fish.enable = true;
    home-manager.users.${mainUser} = {lib, ...}: {
      programs.fish = {
        enable = true;
        interactiveShellInit = lib.strings.concatStrings (lib.strings.intersperse "\n" [
          ''
            # Disable welcome message:
            set fish_greeting

            # Enable z (https://github.com/skywind3000/z.lua):
            ${pkgs.z-lua}/bin/z --init fish | source; set -gx _ZL_CD cd
          ''
        ]);
        functions = {
          fish_title = "basename (prompt_pwd)";
        };
        shellAbbrs = {
          "." = "cd -";
          ".." = "cd ../";
          "..." = "cd ../../";
          cat = "bat";
          d = "docker";
          dc = "docker-compose";
          eo = "$EDITOR .";
          m = "make -s";
          nr = "sudo nixos-rebuild switch";
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
          speedtest = "speedtest-cli --simple";
          stash = "git stash";
        };
        shellAliases = {
          l = "exa --git --icons --level 1 --long --no-filesize --no-permissions --no-time --no-user --tree";
          ll = "l --level 2";
          lll = "l --level 3";
          llll = "l --level 999";
          pp = "prettyping --nolegend";
        };
      };

      home.activation = {
        setFishTheme = lib.hm.dag.entryAfter ["writeBoundary"] ''
          ${pkgs.fish}/bin/fish -c 'yes | fish_config theme save "fish default"'
        '';
      };
    };
  };
}
