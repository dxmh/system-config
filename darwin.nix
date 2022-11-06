{ pkgs, ... }: {

  nix.package = pkgs.nixVersions.stable;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  services.nix-daemon.enable = true;

  environment.variables = {
    EDITOR = "vim";
  };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      iosevka
    ];
  };

  programs.fish.enable = true;

  security.pam.enableSudoTouchIdAuth = true;

  system.defaults.dock = {
    autohide = false;
    autohide-delay = 0.0;
    autohide-time-modifier = 0.2; # Animation duration
    mineffect = "scale";
    minimize-to-application = true;
    mru-spaces = false; # Don't automatically rearrange spaces
    orientation = "bottom";
    show-process-indicators = true;
    show-recents = false;
    tilesize = 48;
  };

  system.defaults.finder = {
    AppleShowAllExtensions = true;
    AppleShowAllFiles = true;
    FXPreferredViewStyle = "clmv"; # Column view
    QuitMenuItem = true;
    ShowPathbar = true;
    ShowStatusBar = true;
  };

  system.defaults.NSGlobalDomain = {
    NSNavPanelExpandedStateForSaveMode = true; # Use expanded save panel by default
    KeyRepeat = 2; # Fastest repeat
    InitialKeyRepeat = 15; # Shortest delay until repeat
    "com.apple.trackpad.enableSecondaryClick" = true;
    "com.apple.trackpad.scaling" = 2.0; # Slowest is 0, fastest is 3
  };

  system.defaults.trackpad = {
    ActuationStrength = 0; # Silent clicking
    Clicking = true; # Tap to click
    TrackpadThreeFingerDrag = true;
    FirstClickThreshold = 0; # "Light" firmness required
    SecondClickThreshold = 0; # "Light" firmness required
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

}
