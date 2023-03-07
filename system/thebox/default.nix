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
  ];

  sops.defaultSopsFile = ../../secrets/example.yaml;
  sops.age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
  sops.secrets.hello = {};

  boot.initrd.availableKernelModules = ["xhci_pci" "virtio_pci" "usbhid" "usb_storage" "sr_mod"];

  networking.hostName = "thebox-vm";

  networking.firewall.interfaces."enp0s1".allowedTCPPorts = [
    143 # IMAP
    993 # IMAPS
  ];

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
    groups.mail = {
      gid = 12;
      members = ["dom" "poppy"];
    };
  };

  services.dovecot2 = {
    enable = true;
    enablePop3 = false;
    enableImap = true;
    enableLmtp = false;
    # TODO: Move to ZFS (may require `mail_privileged_group = mail`)
    mailLocation = "maildir:/TODO/mail/%u"; # Must be 0770 root:mail
  };
}
