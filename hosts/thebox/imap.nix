{...}: {
  networking.firewall.interfaces."enp2s0f0".allowedTCPPorts = [
    143 # IMAP
    993 # IMAPS
  ];

  services.dovecot2 = {
    enable = true;
    enablePop3 = false;
    enableImap = true;
    enableLmtp = false;
    extraConfig = "ssl = required";
    mailLocation = "maildir:/tank/mail/%u"; # Must be 0770 root:mail
    sslServerCert = "/run/secrets/ssl_cert";
    sslServerKey = "/run/secrets/ssl_key";
  };

  sops.secrets = {
    ssl_key.reloadUnits = ["dovecot2.service"];
    ssl_cert.reloadUnits = ["dovecot2.service"];
  };

  users.groups.mail = {
    gid = 12;
    members = [
      "dom"
      "poppy"
    ];
  };
}
