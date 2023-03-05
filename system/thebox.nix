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

  users = {
    mutableUsers = false;
    users.dom = {
      hashedPassword = "$y$j9T$f3NK6qyFlkDxH.Qk/UzFp.$F5jg4/ZBSD5nOOxH53cowSYh6sNJUwxry5lQy2IzNC3";
      uid = 1000;
    };
    users.poppy = {
      createHome = false;
      isNormalUser = true;
      hashedPassword = "$y$j9T$tmtrE/Wd/5bXWi6A34zZ.0$Tn0m6bzc5iDAMuY/3qHw9IFdX2OCojPAcFSEkQW0sg1";
      shell = null;
      uid = 1001;
    };
  };
}
