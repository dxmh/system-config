{
  modulesPath,
  pkgs,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
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
    availableKernelModules = ["xhci_pci" "ahci" "ehci_pci" "usb_storage" "sd_mod"];
    luks.devices = {
      cryptroot.device = "/dev/disk/by-uuid/eee05e8d-cc6f-4e85-9f24-83f28361fdb3";
    };
  };
  boot.kernelModules = ["kvm-amd"];

  hardware.enableAllFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;

  networking.hostName = "thebox";

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

  services.smartd = {
    enable = true;
    autodetect = true; # monitor all devices
    # See https://wiki.archlinux.org/title/S.M.A.R.T.#Complete_smartd.conf_example
    defaults.autodetected = "-a -o on -S on -n standby,q -s (S/../.././02|L/../../6/03)";
    notifications = {
      mail.enable = true;
      test = true;
    };
  };
}
