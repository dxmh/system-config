{
  config,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd = {
    availableKernelModules = ["xhci_pci" "ehci_pci" "ahci" "firewire_ohci" "usbhid" "usb_storage" "sd_mod" "sdhci_pci"];
    luks.devices = {
      "luks-ceb68da4-6a81-44f9-81e4-5012310d41c8".device = "/dev/disk/by-uuid/ceb68da4-6a81-44f9-81e4-5012310d41c8";
    };
  };
  boot.kernelModules = ["kvm-intel" "wl"];
  boot.extraModulePackages = [config.boot.kernelPackages.broadcom_sta];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/db17d9b8-2b8b-4bb1-8459-30cfe4e769d1";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/46B0-1DCF";
    fsType = "vfat";
  };

  hardware.enableAllFirmware = true;
  hardware.cpu.intel.updateMicrocode = true;
}
