{config, ...}: {
  imports = [
    ./hardware.nix
  ];

  environment.systemPackages = [];

  hxy.base = {
    enable = true;
    flakeUri = "/share/";
    stateVersion = {
      home-manager = "22.11";
      nixos = "22.11";
    };
  };

  hxy.git.enable = true;
  hxy.helix.enable = true;

  networking.hostName = "setze-vm";
  networking.firewall.enable = false;

  security.sudo.wheelNeedsPassword = false;

  users.users.${config.hxy.base.mainUser}.extraGroups = ["docker"];
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false; # Start on-demand by socket activation rather than boot
}
