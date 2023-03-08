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
  ];

  sops = {
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    defaultSopsFile = ./secrets.yaml;
    secrets.dom_password.neededForUsers = true;
    secrets.poppy_password.neededForUsers = true;
  };

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
      uid = 1000;
      group = "dom";
      passwordFile = config.sops.secrets.dom_password.path;
    };
    users.poppy = {
      createHome = false;
      isNormalUser = true;
      shell = null;
      uid = 1001;
      group = "poppy";
      passwordFile = config.sops.secrets.poppy_password.path;
    };
    groups = {
      dom.gid = 1000;
      poppy.gid = 1001;
    };
  };
}
