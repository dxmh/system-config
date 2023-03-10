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

  boot.initrd.availableKernelModules = ["xhci_pci" "virtio_pci" "usbhid" "usb_storage" "sr_mod"];

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
