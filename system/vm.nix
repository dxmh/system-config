{ pkgs, ...}: {

  system.stateVersion = "22.05";

  # Configure networking
  networking.useDHCP = false;
  networking.interfaces.eth0.useDHCP = true;

  # Disable the firewall since we're in a VM and we want to make it
  # easy to visit stuff in this VM. We only use NAT networking anyways:
  networking.firewall.enable = false;

  # Create user "test"
  services.getty.autologinUser = "test";
  users.users.test.isNormalUser = true;
  users.users.test.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMpIMrPStsNADURgP6ZXp+1PwMrIMOthUwVLWdP11XBd"
  ];

  # Enable passwordless ‘sudo’ for the "test" user
  users.users.test.extraGroups = ["wheel"];
  security.sudo.wheelNeedsPassword = false;

  # Configure the QEMU virtual machine
  # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/virtualisation/qemu-vm.nix
  virtualisation.vmVariant = {
    virtualisation.graphics = false;
    virtualisation.cores = 4;
    virtualisation.diskSize = 1024;
    virtualisation.memorySize = 8192;
    virtualisation.forwardPorts = [{
        from = "host";
        host.address = "127.0.0.1";
        host.port = 2022;
        guest.port = 22;
    }];
    # virtualisation.sharedDirectories.code= {
    #   source = "/path/on/host";
    #   target = "/path/on/guest";
    # };
  };

  # Open SSH
  services.openssh = {
    enable = true;
    settings = {
      passwordAuthentication = false;
      permitRootLogin = "no";
    };
  };

}
