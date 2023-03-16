{
  config,
  mainUser,
  modulesPath,
  pkgs,
  ...
}: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ../common
    ../../home/aws.nix
  ];

  environment.systemPackages = with pkgs; [
    docker-compose
  ];

  networking.hostName = "cbd";

  # Work around a DHCP issue with UTM/QEMU/macOS
  networking.interfaces.enp0s1 = {
    ipv4.addresses = [
      {
        address = "10.211.56.2";
        prefixLength = 16;
      }
    ];
    ipv4.routes = [
      {
        address = "10.211.0.0";
        prefixLength = 16;
        via = "10.211.56.1";
      }
    ];
    useDHCP = false;
  };
  networking.nameservers = ["10.211.56.1"];

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

  security.sudo.wheelNeedsPassword = false;

  # Automatically log in after boot:
  services.getty.autologinUser = mainUser;

  # Unlock our git config
  sops = {
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    defaultSopsFile = ./secrets.yaml;
    secrets.git_config.owner = mainUser;
  };
  home-manager.users.${mainUser}.programs.git.includes = [
    {path = config.sops.secrets.git_config.path;}
  ];

  users.users.${mainUser}.extraGroups = ["docker"];

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false; # Start on-demand by socket activation rather than boot
  };
}
