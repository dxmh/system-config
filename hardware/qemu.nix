{pkgs, ...}: {
  # Configure networking
  networking.interfaces.eth0.useDHCP = true;

  # Configure the QEMU virtual machine
  # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/virtualisation/qemu-vm.nix
  virtualisation.vmVariant = {
    virtualisation.graphics = false;
    virtualisation.cores = 4;
    virtualisation.diskSize = 8192;
    virtualisation.memorySize = 8192;
    virtualisation.forwardPorts = [
      {
        from = "host";
        host.address = "127.0.0.1";
        host.port = 2022;
        guest.port = 22;
      }
    ];
    # virtualisation.sharedDirectories.code= {
    #   source = "/path/on/host";
    #   target = "/path/on/guest";
    # };
  };
}
