{pkgs, ...}: {
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
}
