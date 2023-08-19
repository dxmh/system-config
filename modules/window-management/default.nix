{
  config,
  lib,
  pkgs,
  ...
}: {
  options.hxy.window-management = {
    enable = lib.mkEnableOption "Enable custom window management";
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
    services.sketchybar = import ./sketchybar.nix {inherit pkgs;};
    homebrew.brews = ["ical-buddy"];

    # Hide macOS menubar and Dock
    system.defaults = {
      NSGlobalDomain._HIHideMenuBar = lib.mkForce true;
      dock.autohide = lib.mkForce true;
    };

    # Hide kitty's titlebar
    home-manager.users.${config.hxy.base.mainUser}.programs = lib.mkIf config.hxy.kitty.graphical {
      kitty.settings.hide_window_decorations = "titlebar-only";
    };
  };
}
