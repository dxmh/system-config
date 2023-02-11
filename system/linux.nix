{ pkgs, ... }: {

  networking = {
    # Disable the firewall since we're in a VM and we want to make it
    # easy to visit stuff in this VM. We only use NAT networking anyways:
    firewall.enable = false;
    hostName = "nixos";
    useDHCP = false;
  };

  nix.gc.dates = "weekly";
  nix.settings.auto-optimise-store = true;

  security.sudo.wheelNeedsPassword = false;

  services.getty.autologinUser = "dom"; # Automatically log in after boot:

  services.openssh = {
    enable = true;
    settings = {
      passwordAuthentication = false;
      permitRootLogin = "no";
    };
  };

  system.stateVersion = "22.11"; # NixOS version used to setup the system initially

  time.timeZone = "Europe/London";

  users.users.dom = {
    isNormalUser = true;
    initialPassword = "hunter2";
    extraGroups = [ "audio" "wheel" "docker" ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [ 
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMpIMrPStsNADURgP6ZXp+1PwMrIMOthUwVLWdP11XBd"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMzUZQgaUystKDL7ox1TgV0LJSc4AcDe5MN9bbAURX6S For NixOS building"
      ];
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false; # Start on-demand by socket activation rather than boot
  };

}
