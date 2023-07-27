{
  lib,
  config,
  platform,
  pkgs,
  ...
}: {
  options.hxy.kitty = {
    enable = lib.mkEnableOption "Enable kitty terminal";
    graphical = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Set up kitty for use in a graphical environment";
    };
  };

  config = lib.mkIf config.hxy.kitty.enable {
    # Commands to use clipboard via kitty (useful for accessing host clipboard
    # from a remote machine over SSH), like macOS's `pbcopy` and `pbpaste`.
    environment.systemPackages = [
      (pkgs.writeShellScriptBin "kccopy" "${pkgs.kitty}/bin/kitty +kitten clipboard")
      (pkgs.writeShellScriptBin "kcpaste" "${pkgs.kitty}/bin/kitty +kitten clipboard --get-clipboard")
    ];

    # Enable shell integration and enhance "truly convenient SSH" functionality
    # by ensuring kitty libs are available when accessing hosts remotely:
    environment.variables = lib.mkIf (platform == "linux") {
      KITTY_INSTALLATION_DIR = "${pkgs.kitty}/lib/kitty";
      EXA_ICON_SPACING = "1";
    };

    home-manager.users.${config.hxy.base.mainUser} = {
      home.sessionVariables = lib.mkIf config.hxy.kitty.graphical {
        SSH_ASKPASS = "false"; # If unset, kitty's askpass implementation breaks
      };

      # Scroll the terminal or the pager:
      home.file = lib.mkIf config.hxy.kitty.graphical {
        ".config/kitty/smart_scroll.py".source = builtins.fetchurl {
          url = "https://raw.githubusercontent.com/yurikhan/kitty-smart-scroll/8aaa91/smart_scroll.py";
          sha256 = "sha256:0p6x51gf4m2r61w894cvzhy6cmvzmadz0jbvvj0clcvq1vh9kc63";
        };
      };

      # Configure kitty itself
      programs.kitty = lib.mkIf config.hxy.kitty.graphical {
        enable = true;
        darwinLaunchOptions = lib.mkIf (platform == "darwin") ["--title='kitty'"];
        keybindings = import ./keybindings.nix;
        settings = import ./settings.nix {inherit pkgs lib config;};
        theme = "Ayu Light"; # Run `kitty +kitten themes` for themes list
        # Font configuration (run `kitty list-fonts --psnames` for font names)
        extraConfig = ''
          font_family SF Mono
          font_size 13
          macos_thicken_font 0.5
          modify_font cell_height 7px
          modify_font cell_width 97%
        '';
      };

      programs.fish = lib.mkIf config.hxy.fish.enable {
        # https://sw.kovidgoyal.net/kitty/shell-integration/#manual-shell-integration
        interactiveShellInit = ''
          set --global KITTY_SHELL_INTEGRATION enabled
          source "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_conf.d/kitty-shell-integration.fish"
          set --prepend fish_complete_path "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_completions.d"
        '';

        # kitty related shell aliases
        shellAliases = lib.mkIf config.hxy.kitty.graphical {
          k = "kitty +kitten ssh";
        };
      };
    };

    # Reload kitty configuration after nixos-rebuild
    system.activationScripts = lib.mkIf config.hxy.kitty.graphical {
      postActivation.text = ''
        killall -SIGUSR1 kitty
      '';
    };
  };
}
