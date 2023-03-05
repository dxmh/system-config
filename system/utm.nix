{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ./linux.nix
  ];

  networking.hostName = "utm-vm";

  boot.initrd.availableKernelModules = ["xhci_pci" "virtio_pci" "usbhid" "usb_storage" "sr_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];

  networking.interfaces.enp0s1.useDHCP = lib.mkDefault true;

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXROOT";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/NIXBOOT";
    fsType = "vfat";
  };

  fileSystems."/code" = {
    device = "/dev/disk/by-label/code";
    fsType = "ext4";
  };

  swapDevices = [];
}
