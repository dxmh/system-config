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

  networking.hostName = "s6s-vm";
  networking.firewall.enable = false;

  security.sudo.wheelNeedsPassword = false;
}
