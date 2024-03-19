{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware.nix
  ];

  environment.systemPackages = [
    pkgs.packer
  ];

  hxy.base = {
    enable = true;
    flakeUri = "/share/";
    stateVersion = {
      home-manager = "22.11";
      nixos = "22.11";
    };
  };

  hxy.aws-tools.enable = true;
  hxy.git.enable = true;
  hxy.helix.enable = true;

  networking.hostName = "dln-vm";
  networking.firewall.enable = false;

  security.sudo.wheelNeedsPassword = false;

  users.users.${config.hxy.base.mainUser}.extraGroups = ["docker"];
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false; # Start on-demand by socket activation rather than boot
}
