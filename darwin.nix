{ pkgs, ... }: {

  nix.package = pkgs.nixVersions.stable;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
    warn-dirty = false
  '';
  services.nix-daemon.enable = true;

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
  };

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
    autohide = true;
    autohide-delay = 0.0;
    autohide-time-modifier = 0.2; # Animation duration
    mineffect = "scale";
    minimize-to-application = true;
    mru-spaces = false; # Don't automatically rearrange spaces
    orientation = "bottom";
    show-process-indicators = true;
    show-recents = false;
    static-only = true;
    tilesize = 45;
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
    "com.apple.trackpad.scaling" = 3.0; # Slowest is 0, fastest is 3
  };

  system.defaults.screencapture = {
    disable-shadow = true;
  };

  system.defaults.trackpad = {
    ActuationStrength = 0; # Silent clicking
    Clicking = true; # Tap to click
    TrackpadThreeFingerDrag = true;
    FirstClickThreshold = 0; # "Light" firmness required
    SecondClickThreshold = 0; # "Light" firmness required
  };

  # Key remapping
  # https://developer.apple.com/library/archive/technotes/tn2450/
  system.keyboard = {
    enableKeyMapping = true;
    userKeyMapping = [
      {
        HIDKeyboardModifierMappingSrc = 30064771129; # CapsLock
        HIDKeyboardModifierMappingDst = 30064771177; # F14
      }
    ];
  };

}
