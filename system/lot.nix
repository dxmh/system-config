{pkgs, ...}: {
  imports = [./darwin.nix];

  environment = {
    systemPackages = [
      pkgs.docker-client
    ];
    variables = {
      DOCKER_HOST = "ssh://nixos-vm";
    };
  };

  homebrew.casks = [
    "discord"
    "element"
    "google-chrome"
    "parallels"
    "signal"
    "slack"
    "syncthing"
    "utm"
    "zoom"
  ];

  # Configuration for building NixOS VM from macOS
  nix = {
    distributedBuilds = true;
    buildMachines = [
      {
        hostName = "nixos-vm"; # Parallels VM
        system = "aarch64-linux";
        sshUser = "dom";
      }
    ];
    extraOptions = ''
      builders-use-substitutes = true
    '';
  };
}
