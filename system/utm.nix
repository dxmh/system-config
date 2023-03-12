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

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXROOT";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-label/NIXBOOT";
    fsType = "vfat";
  };
  fileSystems."/code" = {
    device = "/dev/disk/by-label/code";
    fsType = "ext4";
    options = ["defaults" "nofail"];
  };
  fileSystems."/share" = {
    device = "share";
    fsType = "9p";
    options = ["defaults" "nofail"];
  };

  # Automatically log in after boot:
  services.getty.autologinUser = mainUser;

  # Unlock our git config
  sops = {
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    defaultSopsFile = ./utm/secrets.yaml;
    secrets.git_config.owner = mainUser;
  };
  home-manager.users.${mainUser}.programs.git.includes = [
    {path = config.sops.secrets.git_config.path;}
  ];

  # NixOS version used to setup the system initially:
  system.stateVersion = "22.11";

  users.users.${mainUser}.extraGroups = ["docker"];

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false; # Start on-demand by socket activation rather than boot
  };
}
