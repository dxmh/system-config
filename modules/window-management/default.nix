{
  config,
  lib,
  pkgs,
  ...
}: {
  options.hxy.window-management = {
    enable = lib.mkEnableOption "Enable custom window management";
    space-icons = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Bash array of icons to use for spaces";
    };
  };

  config = lib.mkIf config.hxy.window-management.enable {
    # Window manager
    services.yabai = import ./yabai.nix {inherit pkgs;};

    # Hotkey daemon
    services.skhd = {
      enable = true;
      skhdConfig = import ./skhd.nix {inherit pkgs;};
    };

    # Status bar
    services.sketchybar = import ./sketchybar.nix {inherit config pkgs;};
    homebrew.brews = ["ical-buddy"];

    # Hide macOS menubar and Dock
    system.defaults.NSGlobalDomain._HIHideMenuBar = lib.mkForce true;
    system.defaults.dock.autohide = lib.mkForce true;

    # Disable macOS Mission Control hot corners
    system.defaults.dock.wvous-bl-corner = lib.mkForce 1;
    system.defaults.dock.wvous-br-corner = lib.mkForce 1;
    system.defaults.dock.wvous-tl-corner = lib.mkForce 1;
    system.defaults.dock.wvous-tr-corner = lib.mkForce 1;

    # Hide kitty's titlebar
    home-manager.users.${config.hxy.base.mainUser}.programs = lib.mkIf config.hxy.kitty.graphical {
      kitty.settings.hide_window_decorations = "titlebar-only";
    };
  };
}
