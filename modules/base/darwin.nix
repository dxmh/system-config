{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.hxy.base.enable {
    system.stateVersion = config.hxy.base.stateVersion.nix-darwin;

    # Our home directory needs to be set for certain things to work, such as
    # launchd agents (otherwise it defaults to /var/empty/)
    users.users.${config.hxy.base.mainUser}.home = "/Users/${config.hxy.base.mainUser}";

    hxy.window-management.enable = lib.mkDefault true;
    hxy.kitty.graphical = true;

    environment.systemPath = [
      "/opt/homebrew/bin"
    ];

    services.nix-daemon.enable = true;

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
      appswitcher-all-displays = false;
      autohide = false;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.2; # Animation duration
      mineffect = "scale";
      minimize-to-application = false;
      mru-spaces = false; # Don't automatically rearrange spaces
      orientation = "left";
      show-process-indicators = true; # Show dots for open applications
      show-recents = false;
      static-only = false; # Whether to show only open applications in the Dock
      showhidden = false; # Whether to dim hidden applications in the Dock
      tilesize = 48;
      largesize = 56;
      # Hot corners:
      wvous-bl-corner = 1;
      wvous-br-corner = 1;
      wvous-tl-corner = 1;
      wvous-tr-corner = 1;
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
      _HIHideMenuBar = false; # Don't hide menubar
      AppleICUForce24HourTime = false; # Use 12-hour clock
      NSNavPanelExpandedStateForSaveMode = true; # Use expanded save panel by default
      KeyRepeat = 2; # Fastest repeat
      InitialKeyRepeat = 15; # Shortest delay until repeat
      "com.apple.trackpad.enableSecondaryClick" = true;
      "com.apple.trackpad.scaling" = 3.0; # Slowest is 0, fastest is 3
    };

    system.defaults.screencapture = {
      disable-shadow = false;
      location = "~/Pictures/Screenshots/";
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

    homebrew = {
      enable = true;
      global.autoUpdate = true;
      onActivation = {
        autoUpdate = true;
        upgrade = true;
        cleanup = "zap";
      };
      brews = [
        "zap"
      ];
      taps = [
        "keith/formulae"
      ];
      casks = [
        "lunar"
        "raycast"
        "sf-symbols"
        "mac-mouse-fix"
        "utm"
      ];
      masApps = {
        "hush-nag-blocker" = 1544743900;
        "StopTheMadnessPro" = 6471380298;
        "Vimari" = 1480933944;
        "wipr" = 1320666476;
      };
    };

    # Allow these users to specify additional binary caches
    nix.settings.trusted-users = ["@admin"];
  };
}
