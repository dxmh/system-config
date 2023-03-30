{
  config,
  pkgs,
  ...
}: {
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
    "rss2email"
  ];

  # A oneshot systemd service that sends an email about the status of another
  # systemd unit. I use this to receive email alerts when services fail, with
  # `OnFailure=systemd-status-email@%n.service`.
  systemd.services."systemd-status-email@" = {
    description = "Send email about systemd unit status";
    serviceConfig.Type = "oneshot";
    script = ''
      ${pkgs.msmtp}/bin/msmtp -t <<MAIL
      To: root
      Subject: $1 $(systemctl is-failed "$1")
      Content-Type: text/html; charset=UTF-8
      <pre><code>
      $(systemctl status --full "$1")
      </pre></code>
      MAIL
    '';
    scriptArgs = "%i";
  };
}
