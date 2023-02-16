{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [./linux.nix];

  networking.hostName = "prl-vm";

  boot.initrd.availableKernelModules = ["xhci_pci" "usbhid" "sr_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];

  boot.loader = {
    timeout = 1;
    efi.canTouchEfiVariables = true;
    systemd-boot = {
      enable = true;
      consoleMode = "0"; # Fix "error switching console mode" on boot in Parallels
      configurationLimit = 5; # Prevent infinite generations filling up /boot
    };
  };

  networking.interfaces.enp0s5.useDHCP = true;

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXROOT";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/NIXBOOT";
    fsType = "vfat";
  };

  swapDevices = [];

  hardware.parallels.enable = true;
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) ["prl-tools"];
}
