{modulesPath, ...}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd = {
    availableKernelModules = ["xhci_pci" "nvme" "usb_storage" "uas" "sd_mod"];
    luks.devices = {
      cryptroot.device = "/dev/disk/by-uuid/d79505af-08f7-43f7-8fc2-7c465de0527f";
    };
  };
  boot.kernelModules = ["kvm-intel"];

  hardware.enableAllFirmware = true;
  hardware.cpu.intel.updateMicrocode = true;

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/de866900-c7f0-41ef-baf3-fd327a349621";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/64A6-FF34";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };
}
