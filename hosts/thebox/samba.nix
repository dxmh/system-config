{
  config,
  lib,
  pkgs,
  ...
}: {
  services.samba = {
    enable = true;
    openFirewall = true;
    extraConfig = ''
      # Secure connections
      hosts allow = 10.0.10.0/24
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
  };

  services.samba.shares = {
    shared = {
      "create mode" = "0660";
      "directory mode" = "0770";
      "force user" = "dom";
      "force group" = "samba-users";
      "path" = "/tank/shared";
      "public" = "no";
      "valid users" = "dom poppy";
      "writeable" = "yes";
    };
    dom = {
      "create mode" = "0640";
      "directory mode" = "0740";
      "force user" = "dom";
      "path" = "/tank/dom";
      "valid users" = "dom";
      "public" = "no";
      "writable" = "yes";
    };
    poppy = {
      "create mode" = "0640";
      "directory mode" = "0740";
      "force user" = "poppy";
      "path" = "/tank/poppy";
      "valid users" = "poppy";
      "public" = "no";
      "writable" = "yes";
    };
    media = {
      "path" = "/tank/media";
      "public" = "yes";
      "writable" = "no";
      "guest account" = "nobody";
    };
  };

  users.groups.samba-users = {
    gid = 1002;
    members = ["dom" "poppy"];
  };

  sops.secrets = {
    dom_password = {};
    poppy_password = {};
  };

  system.activationScripts = lib.mkIf config.services.samba.enable {
    sambaUserSetup = {
      text = lib.strings.concatMapStrings (user: ''
        password=$(<${config.sops.secrets."${user}_password".path})
        printf '%s\n%s\n' "$password" "$password" \
          | ${pkgs.samba}/bin/smbpasswd -s -a ${user}
      '') ["dom" "poppy"];
      deps = ["setupSecrets"];
    };
  };
}
