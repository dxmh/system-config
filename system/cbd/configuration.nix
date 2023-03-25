{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./samba.nix
  ];

  boot.kernel.sysctl."net.ipv4.conf.all.forwarding" = true;

  environment.systemPackages = with pkgs; [docker-compose];

  hxy.aws-tools.enable = true;
  hxy.base.enable = true;
  hxy.git.enable = true;
  hxy.helix.enable = true;

  networking.firewall.enable = false;

  security.sudo.wheelNeedsPassword = false;

  services.getty.autologinUser = config.hxy.base.mainUser;

  services.syncthing.enable = false;
  services.syncthing.guiAddress = "0.0.0.0:8384";
  services.syncthing.user = config.hxy.base.mainUser;
  services.syncthing.group = "users";
  services.syncthing.dataDir = "/home/${config.hxy.base.mainUser}/";

  services.tailscale.enable = true;

  services.timesyncd.enable = true;

  sops.age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
  sops.defaultSopsFile = ./secrets.yaml;

  sops.secrets.git_config.owner = config.hxy.base.mainUser;
  home-manager.users.${config.hxy.base.mainUser}.programs.git.includes = [
    {path = config.sops.secrets.git_config.path;}
  ];

  users.users.${config.hxy.base.mainUser} = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBq0PlWKuCdj/4rj3cWgRMSArd8sMBpldmiVlmg30yF3"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKTN5m5oFLLw4DjcxOniBto8vOG7I+grLcNjCZl4iOPp"
    ];
    extraGroups = ["docker"];
  };

  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false; # Start on-demand by socket activation rather than boot
}
