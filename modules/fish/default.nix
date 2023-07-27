{
  config,
  lib,
  pkgs,
  ...
}: {
  options.hxy.fish.enable = lib.mkEnableOption "Enable fish shell";

  config = lib.mkIf config.hxy.fish.enable {
    # Let the system know that fish is an available shell:
    programs.fish.enable = true;

    home-manager.users.${config.hxy.base.mainUser} = {lib, ...}: {
      home.sessionVariables = {
        SHELL = "${pkgs.fish}/bin/fish";
      };

      home.activation = {
        setFishTheme = lib.hm.dag.entryAfter ["writeBoundary"] ''
          ${pkgs.fish}/bin/fish -c 'yes | fish_config theme save "ayu Light"'
        '';
      };

      programs.fish.enable = true;

      programs.fish.interactiveShellInit = ''
        # Disable welcome message:
        set fish_greeting

        # Enable z (https://github.com/skywind3000/z.lua):
        ${pkgs.z-lua}/bin/z --init fish | source; set -gx _ZL_CD cd

        # Abbreviations that nix isn't yet capable of configuring
        abbr -ag --set-cursor -- nr \
          "sudo nixos-rebuild switch --flake ${config.hxy.base.flakeUri}% &| nom"

        # Undo/redo
        bind \ez undo
        bind \eZ redo

        # Remap alt-up/down to shift-up/down:
        bind -k sr history-token-search-backward
        bind -k sf history-token-search-forward
      '';

      programs.fish.functions = {
        fish_title = "basename (prompt_pwd)";
      };

      programs.fish.shellAbbrs = {
        "." = "cd -";
        ".." = "cd ../";
        "..." = "cd ../../";
        cat = "bat";
        d = "docker";
        dc = "docker-compose";
        eo = "$EDITOR .";
        m = "make -s";
        vim = lib.mkIf config.hxy.helix.enable "hx";
        "g." = "git switch -";
        g = "git";
        gc = "git commit -v";
        gco = "git checkout";
        gcop = "git checkout -p";
        gcp = "git commit -v -p";
        gcpa = "git commit -v -p --amend";
        gd = "git diff";
        gr = "git rebase -i";
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
        start = "sudo systemctl start";
        stop = "sudo systemctl stop";
        restart = "sudo systemctl restart";
        status = "sudo systemctl status";
        enable = "sudo systemctl enable";
        disable = "sudo systemctl disable";
      };

      programs.fish.shellAliases = {
        l = "exa --git --icons --level 1 --long --no-filesize --no-permissions --no-time --no-user --tree --group-directories-first";
        ll = "l --level 2";
        lll = "l --level 3";
        llll = "l --level 999";
        pp = "prettyping --nolegend";
      };

      programs.fzf = {
        enable = true;
        enableFishIntegration = true;
      };

      # http://starship.rs/config/
      programs.starship = {
        enable = true;
        enableFishIntegration = true;
        settings = {
          add_newline = false;
          aws.disabled = true;
          character.error_symbol = "[\⟩](red)";
          character.success_symbol = "[\⟩](dimmed black)";
          docker_context.disabled = true;
          format = "\$all\$hostname\$status\$character";
          git_status.disabled = true;
          git_branch.symbol = " ";
          hostname = {
            ssh_only = true;
            ssh_symbol = "";
            format = "[\$ssh_symbol\$hostname](\$style) ";
            style = "dimmed black";
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
    };
  };
}
