{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware.nix
  ];

  environment.systemPackages = [];

  hxy.base = {
    enable = true;
    stateVersion = {
      home-manager = "24.05";
      nixos = "24.05";
    };
  };

  hxy.git.enable = true;
  hxy.helix.enable = true;

  networking.hostName = "m1p";

  # Specify path to peripheral firmware files
  hardware.asahi.peripheralFirmwareDirectory = /boot/asahi;

  # Use iwd instead of wpa_supplicant on Apple Silicon
  networking.wireless.iwd = {
    enable = true;
    settings.General.EnableNetworkConfiguration = true;
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # TODO: Turn the graphical environment setup (below) into a module

  # Configure user
  users.users.${config.hxy.base.mainUser} = {
    packages = with pkgs; [
      firefox
    ];
  };

  # Enable a graphical environment
  services.xserver = {
    enable = true;
    layout = "us";
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

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Remove some of the default graphical packages
  services.xserver.excludePackages = [pkgs.xterm];
  environment.gnome.excludePackages =
    (with pkgs; [
      gnome-photos
      gnome-tour
      epiphany # web browser
      geary # email client
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
}
