{pkgs, ...}: {
  boot = {
    supportedFilesystems = ["zfs"];
    zfs = {
      extraPools = ["tank"]; # Import tank on boot
      devNodes = "/dev/mapper/"; # My zpools use `/dev/mapper/` paths
    };
  };

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

  # Reconfigure ZED so it can send emails.
  # See /etc/zfs/zed.d/zed.rc for info about these options.
  services.zfs.zed.settings = {
    ZED_DEBUG_LOG = "/tmp/zed.debug.log";
    ZED_EMAIL_ADDR = ["root"];
    ZED_EMAIL_PROG = "${pkgs.msmtp}/bin/msmtp";
    ZED_EMAIL_OPTS = "@ADDRESS@";
    ZED_NOTIFY_INTERVAL_SECS = 3600;
    ZED_NOTIFY_VERBOSE = false;
    ZED_SCRUB_AFTER_RESILVER = true;
  };
}
