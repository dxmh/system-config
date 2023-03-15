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
      luks_W1F4LD40 UUID=5bc8f3bd-ed49-4e4f-8361-ce34cedd0b95 /etc/luks_keyfile.bin
      luks_W1F4KPPJ UUID=443c140a-b08e-480a-985d-534ec9e661a7 /etc/luks_keyfile.bin
      luks_W1F4LCXG UUID=779b4a27-27f7-4b69-8f4d-68e23f8e61b9 /etc/luks_keyfile.bin
      luks_W1F4KDZF UUID=000382b3-c73e-4c68-98a6-40b61a29464d /etc/luks_keyfile.bin
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
