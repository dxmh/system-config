{modulesPath, ...}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd = {
    availableKernelModules = ["xhci_pci" "ahci" "ehci_pci" "usb_storage" "sd_mod"];
    luks.devices = {
      cryptroot.device = "/dev/disk/by-uuid/eee05e8d-cc6f-4e85-9f24-83f28361fdb3";
    };
  };
  boot.kernelModules = ["kvm-amd"];

  hardware.enableAllFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-label/nixboot";
    fsType = "vfat";
  };
}
