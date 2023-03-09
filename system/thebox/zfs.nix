{...}: {
  boot.supportedFilesystems = ["zfs"];

  networking.hostId = "000a020a";

  services.zfs.autoScrub = {
    interval = "Sat, 02:00";
    enable = true;
  };
}
