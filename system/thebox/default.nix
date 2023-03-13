{
  modulesPath,
  pkgs,
  ...
}: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ../common
    ./backup.nix
    ./imap.nix
    ./samba.nix
    ./sendmail.nix
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

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-label/nixboot";
    fsType = "vfat";
  };
  fileSystems."/share" = {
    device = "share";
    fsType = "9p";
    options = ["defaults" "nofail"];
  };

  services.smartd = {
    enable = true;
    autodetect = true; # monitor all devices
    # See https://wiki.archlinux.org/title/S.M.A.R.T.#Complete_smartd.conf_example
    defaults.autodetected = "-a -o on -S on -n standby,q -s (S/../.././02|L/../../6/03)";
    extraOptions = [
      "-q never" # Don't error if no physical disks are present (in our VM)
    ];
    notifications = {
      mail.enable = true;
      test = true;
    };
  };

  # NixOS version used to setup the system initially:
  system.stateVersion = "22.11";
}
