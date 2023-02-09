{ pkgs, ... }: {

  imports = [
    ./brew.nix
  ];

  environment.systemPath = [
    "/opt/homebrew/bin"
  ];

  services.nix-daemon.enable = true;

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      iosevka
    ];
  };

  # While it’s possible to set `nix.settings.auto-optimise-store`, it sometimes
  # causes problems on Darwin. So run a job periodically to optimise the store:
  launchd.daemons."nix-store-optimise".serviceConfig = {
    ProgramArguments = [
      "/bin/sh"
      "-c"
      ''
        /bin/wait4path ${pkgs.nix}/bin/nix && \
          exec ${pkgs.nix}/bin/nix store optimise
      ''
    ];
    StartCalendarInterval = [
      {
        Hour = 2;
        Minute = 30;
      }
    ];
    StandardErrorPath = "/var/log/nix-store.log";
    StandardOutPath = "/var/log/nix-store.log";
  };

  security.pam.enableSudoTouchIdAuth = true;

  system.defaults.dock = {
    appswitcher-all-displays = true;
    autohide = false;
    autohide-delay = 0.0;
    autohide-time-modifier = 0.2; # Animation duration
    mineffect = "scale";
    minimize-to-application = true;
    mru-spaces = false; # Don't automatically rearrange spaces
    orientation = "left";
    show-process-indicators = false; # Show dots for open applications
    show-recents = true;
    static-only = false; # Whether to show only open applications in the Dock
    tilesize = 40;
  };

  system.defaults.finder = {
    AppleShowAllExtensions = true;
    AppleShowAllFiles = false;
    FXPreferredViewStyle = "clmv"; # Column view
    QuitMenuItem = true;
    ShowPathbar = true;
    ShowStatusBar = true;
  };

  system.defaults.NSGlobalDomain = {
    AppleICUForce24HourTime = false; # Use 12-hour clock
    NSNavPanelExpandedStateForSaveMode = true; # Use expanded save panel by default
    KeyRepeat = 2; # Fastest repeat
    InitialKeyRepeat = 15; # Shortest delay until repeat
    "com.apple.trackpad.enableSecondaryClick" = true;
    "com.apple.trackpad.scaling" = 3.0; # Slowest is 0, fastest is 3
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
    nonUS.remapTilde = true;
    remapCapsLockToControl = true;
  };

}
