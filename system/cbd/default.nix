{
  config,
  mainUser,
  pkgs,
  ...
}: {
  imports = [
    ./hardware.nix
    ../common
    ../../home/aws.nix
  ];

  environment.systemPackages = with pkgs; [docker-compose];

  networking.hostName = "cbd";
  networking.firewall.enable = false;

  security.sudo.wheelNeedsPassword = false;

  sops.age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
  sops.defaultSopsFile = ./secrets.yaml;

  sops.secrets.git_config.owner = mainUser;
  home-manager.users.${mainUser}.programs.git.includes = [
    {path = config.sops.secrets.git_config.path;}
  ];

  users.users.${mainUser}.extraGroups = ["docker"];
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false; # Start on-demand by socket activation rather than boot
}
