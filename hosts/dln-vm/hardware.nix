{
  config,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "virtio_pci"
    "usbhid"
    "usb_storage"
    "sr_mod"
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
    "/data" = {
      device = "/dev/disk/by-label/data";
      fsType = "ext4";
      options = ["defaults" "nofail"];
    };
    "/share" = {
      device = "share";
      fsType = "9p";
      options = ["defaults" "nofail"];
    };
  };

  # # Work around a DHCP issue with UTM/QEMU/macOS
  # networking.defaultGateway.address = "10.211.56.1";
  # networking.interfaces.enp0s1 = {
  #   ipv4.addresses = [
  #     {
  #       address = "10.211.56.3";
  #       prefixLength = 16;
  #     }
  #   ];
  #   useDHCP = false;
  # };
  # networking.nameservers = ["10.211.56.1"];

  services.getty.autologinUser = config.hxy.base.mainUser;
}
