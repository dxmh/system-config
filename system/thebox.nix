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

  boot.initrd.availableKernelModules = ["xhci_pci" "virtio_pci" "usbhid" "usb_storage" "sr_mod"];

  networking.hostName = "thebox-vm";

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
    };
    "/share" = {
      device = "share";
      fsType = "9p";
      options = ["defaults" "nofail"];
    };
  };
}
