{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware.nix
  ];

  hxy.base = {
    enable = true;
    stateVersion = {
      home-manager = "24.05";
      nixos = "24.05";
    };
  };

  networking.hostName = "t480";

  # TODO: Turn the graphical environment setup (below) into a module

  # Enable network manager
  networking.networkmanager.enable = true;

  # Configure user
  users.users.${config.hxy.base.mainUser} = {
    extraGroups = [
      "networkmanager"
    ];
    packages = with pkgs; [
      firefox
    ];
  };

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_GB.UTF-8";
      LC_IDENTIFICATION = "en_GB.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_MONETARY = "en_GB.UTF-8";
      LC_NAME = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_PAPER = "en_GB.UTF-8";
      LC_TELEPHONE = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "gb";
    xkbVariant = "";
    displayManager = {
      gdm.enable = true;
      autoLogin = {
        enable = true;
        user = config.hxy.base.mainUser;
      };
    };
    desktopManager.gnome.enable = true;
  };

  # Remove some of the default packages
  services.xserver.excludePackages = [pkgs.xterm];
  environment.gnome.excludePackages =
    (with pkgs; [
      gnome-photos
      gnome-tour
    ])
    ++ (with pkgs.gnome; [
      gnome-characters
      gnome-clocks
      gnome-contacts
      gnome-maps
      gnome-music
      gnome-weather
      totem # video player
      yelp # help viewer
    ]);

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
}
