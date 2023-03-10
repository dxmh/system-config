{...}: {
  boot.supportedFilesystems = ["zfs"];

  # Automatically decrypt LUKS volumes on boot so ZFS can use them
  environment.etc.crypttab = {
    mode = "0600";
    text = ''
      luks_test UUID=5f53fec8-88ca-473e-86f1-cac849b33336 /etc/luks_keyfile.bin
    '';
  };

  networking.hostId = "000a020a";

  services.zfs.autoScrub = {
    interval = "Sat, 02:00";
    enable = true;
  };
}
