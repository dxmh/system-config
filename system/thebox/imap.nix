{...}: {
  networking.firewall.interfaces."enp0s1".allowedTCPPorts = [
    143 # IMAP
    993 # IMAPS
  ];

  services.dovecot2 = {
    enable = true;
    enablePop3 = false;
    enableImap = true;
    enableLmtp = false;
    extraConfig = "ssl = required";
    # TODO: Move to ZFS (may require `mail_privileged_group = mail`)
    mailLocation = "maildir:/TODO/mail/%u"; # Must be 0770 root:mail
    sslServerCert = "/run/secrets/ssl_cert";
    sslServerKey = "/run/secrets/ssl_key";
  };

  sops.secrets = {
    ssl_key = {};
    ssl_cert = {};
  };

  users.groups.mail = {
    gid = 12;
    members = [
      "dom"
      "poppy"
    ];
  };
}