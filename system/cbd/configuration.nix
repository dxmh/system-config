{
  config,
  mainUser,
  pkgs,
  ...
}: {
  imports = [
    ../common
    ../../home/aws.nix
  ];

  environment.systemPackages = with pkgs; [docker-compose];

  environment.etc."nixos/flake.nix".source = "/share/flake.nix";

  networking.firewall.enable = false;

  security.sudo.wheelNeedsPassword = false;

  services.getty.autologinUser = mainUser;

  services.tailscale.enable = true;

  sops.age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
  sops.defaultSopsFile = ./secrets.yaml;

  sops.secrets.git_config.owner = mainUser;
  home-manager.users.${mainUser}.programs.git.includes = [
    {path = config.sops.secrets.git_config.path;}
  ];

  users.users.${mainUser} = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBq0PlWKuCdj/4rj3cWgRMSArd8sMBpldmiVlmg30yF3"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKTN5m5oFLLw4DjcxOniBto8vOG7I+grLcNjCZl4iOPp"
    ];
    extraGroups = ["docker"];
  };

  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false; # Start on-demand by socket activation rather than boot
}
