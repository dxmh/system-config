{
  config,
  pkgs,
  ...
}: {
  services.samba = {
    enable = true;
    openFirewall = true;
    extraConfig = ''
      # Secure connections
      server min protocol = SMB2
      server smb encrypt = required

      # Optimisations
      socket options = TCP_NODELAY IPTOS_LOWDELAY
      use sendfile = yes
      disable netbios = yes
      dns proxy = no

      # Mac-friendly client settings
      vfs objects = catia fruit streams_xattr
      fruit:aapl = yes
      fruit:resource = xattr
      fruit:metadata = stream
      fruit:encoding = native

      # File cleanup
      fruit:veto_appledouble = no
      fruit:wipe_intentionally_left_blank_rfork = yes
      fruit:delete_empty_adfiles = yes

      # Disable support for modifying the UNIX mode of directory entries
      fruit:nfs_aces = no
    '';
    shares.${config.networking.hostName} = {
      "create mode" = "0640";
      "directory mode" = "0740";
      "force user" = config.hxy.base.mainUser;
      "path" = "/srv/share";
      "valid users" = config.hxy.base.mainUser;
      "public" = "no";
      "writable" = "yes";
    };
  };

  sops.secrets.samba_password = {
    mode = "400";
  };

  system.activationScripts = {
    sambaUserSetup = {
      text = ''
        mkdir -pv /srv/share
        chown -c ${config.hxy.base.mainUser}:users /srv/share
        password=$(<${config.sops.secrets.samba_password.path})
        printf '%s\n%s\n' "$password" "$password" \
          | ${pkgs.samba}/bin/smbpasswd -s -a ${config.hxy.base.mainUser}
      '';
      deps = ["setupSecrets"];
    };
  };
}
