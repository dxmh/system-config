{mainUser, ...}: {
  imports = [
    ../common
    ./hardware-configuration.nix
  ];

  environment.systemPackages = [];

  environment.etc."nixos/flake.nix".source = "/share/flake.nix";

  networking.hostName = "setze-vm";
  networking.firewall.enable = false;

  security.sudo.wheelNeedsPassword = false;

  home-manager.users.${mainUser} = {
    programs.git = {
      userEmail = "dom@hxy.io";
      userName = "Dom H";
    };
  };

  users.users.${mainUser}.extraGroups = ["docker"];
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false; # Start on-demand by socket activation rather than boot
}
