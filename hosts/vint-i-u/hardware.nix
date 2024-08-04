{modulesPath, ...}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd = {
    availableKernelModules = ["uhci_hcd" "ehci_pci" "ahci" "firewire_ohci" "usbhid" "usb_storage" "sd_mod" "sr_mod"];
    luks.devices = {
      "luks-58b1057e-2a0f-4c79-841d-d5af64da8959".device = "/dev/disk/by-uuid/58b1057e-2a0f-4c79-841d-d5af64da8959";
    };
  };
  boot.kernelModules = ["kvm-intel"];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/fe0e3897-af5c-4d94-ad84-19b3a256b965";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/3533-2D1B";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  hardware.enableAllFirmware = true;
  hardware.cpu.intel.updateMicrocode = true;
}
