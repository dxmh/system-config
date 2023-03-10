{config, ...}: {
  programs.msmtp = {
    enable = true;
  };

  # Configure mappings between a local address and a list of replacement
  # addresses. In this case we just configure a single "catch all" address.
  environment.etc.aliases.text = ''
    default: dom@hxy.io
  '';

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
