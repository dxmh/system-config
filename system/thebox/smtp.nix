{config, ...}: {
  programs.msmtp = {
    enable = true;
  };

  # Overwrite NixOS's msmtprc config file with the one from our secrets
  sops.secrets = {
    msmtprc = {
      mode = "0440";
      owner = "root";
      group = "msmtp";
      path = "/etc/msmtprc";
    };
  };

  # msmtp has no daemon and runs as the invoking user, therefore the
  # configuration file must be readable by any user that wishes to send mail.
  # So we use a group to permit access to this file.
  users.groups.msmtp.members = [
    "dom"
  ];
}
