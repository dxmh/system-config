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
      home-manager = "23.11";
      nixos = "23.11";
    };
  };

  hxy.helix.enable = true;

  networking.hostName = "quinze";

  # TODO: Turn the graphical environment setup (below) into a module

  # Enable network manager
  networking.networkmanager.enable = true;
  users.users.${config.hxy.base.mainUser}.extraGroups = ["networkmanager"];
  users.users.${config.hxy.base.mainUser}.packages = with pkgs; [
    firefox
    gnome.gnome-boxes
  ];

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
