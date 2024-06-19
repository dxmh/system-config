{
  config,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "virtio_pci"
    "usbhid"
    "usb_storage"
    "sr_mod"
  ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/nixboot";
      fsType = "vfat";
    };
    "/share" = {
      device = "share";
      fsType = "9p";
      options = ["defaults" "nofail"];
    };
  };

  services.getty.autologinUser = config.hxy.base.mainUser;
}
