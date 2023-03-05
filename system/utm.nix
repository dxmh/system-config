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

  # Disable the firewall since we're in a VM and we want to make it
  # easy to visit stuff in this VM. We only use NAT networking anyways:
  networking.firewall.enable = false;

  boot.initrd.availableKernelModules = ["xhci_pci" "virtio_pci" "usbhid" "usb_storage" "sr_mod"];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
    };
    "/code" = {
      device = "/dev/disk/by-label/code";
      fsType = "ext4";
      options = ["defaults" "nofail"];
    };
  };
}
