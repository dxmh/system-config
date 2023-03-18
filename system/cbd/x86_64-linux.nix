{modulesPath, ...}: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ./configuration.nix
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "uhci_hcd"
    "ehci_pci"
    "ahci"
    "usbhid"
    "sd_mod"
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
    "/code" = {
      device = "/dev/disk/by-label/code";
      fsType = "ext4";
      options = ["defaults" "nofail"];
    };
    "/share" = {
      device = "share";
      fsType = "9p";
      options = ["defaults" "nofail"];
    };
  };

  networking.hostName = "cbdx";
}
