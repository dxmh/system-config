{
  config,
  lib,
  pkgs,
  modulesPath,
  mainUser,
  ...
}: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ./linux.nix
    ../home/aws.nix
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
    "/share" = {
      device = "share";
      fsType = "9p";
      options = ["defaults" "nofail"];
    };
  };

  # Automatically log in after boot:
  services.getty.autologinUser = mainUser;

  # NixOS version used to setup the system initially:
  system.stateVersion = "22.11";

  users.users.${mainUser}.extraGroups = ["docker"];

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false; # Start on-demand by socket activation rather than boot
  };
}
