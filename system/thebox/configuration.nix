{pkgs, ...}: {
  imports = [
    ./backup.nix
    ./hardware-configuration.nix
    ./imap.nix
    ./samba.nix
    ./sendmail.nix
    ./users.nix
    ./zfs.nix
  ];

  sops = {
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    defaultSopsFile = ./secrets.yaml;
  };

  networking.hostName = "thebox";

  environment.systemPackages = [
    pkgs.cryptsetup
  ];

  services.smartd = {
    enable = true;
    autodetect = true; # monitor all devices
    # See https://wiki.archlinux.org/title/S.M.A.R.T.#Complete_smartd.conf_example
    defaults.autodetected = "-a -o on -S on -n standby,q -s (S/../.././02|L/../../6/03)";
    notifications = {
      mail.enable = true;
      test = true;
    };
  };

  systemd.services."nixos-upgrade".onFailure = ["systemd-status-email@%n.service"];
}
