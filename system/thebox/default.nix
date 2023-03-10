{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ../linux.nix
    ./imap.nix
    ./samba.nix
    ./users.nix
    ./zfs.nix
  ];

  sops = {
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    defaultSopsFile = ./secrets.yaml;
  };

  boot.initrd = {
    availableKernelModules = ["xhci_pci" "virtio_pci" "usbhid" "usb_storage" "sr_mod"];
    luks.devices = {
      cryptroot.device = "/dev/disk/by-uuid/29b528a6-aac9-4b79-ab71-ab78ded2536b";
    };
  };

  networking.hostName = "thebox-vm";

  environment.systemPackages = [
    pkgs.cryptsetup
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
}
