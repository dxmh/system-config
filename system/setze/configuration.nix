{mainUser, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  environment.systemPackages = [];

  hxy.base.enable = true;
  hxy.base.flakeUri = "/share/";

  hxy.git.enable = true;
  hxy.helix.enable = true;

  networking.hostName = "setze-vm";
  networking.firewall.enable = false;

  security.sudo.wheelNeedsPassword = false;

  users.users.${mainUser}.extraGroups = ["docker"];
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false; # Start on-demand by socket activation rather than boot
}
